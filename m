Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B0584950
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiG2BX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 21:23:26 -0400
Received: from out20-13.mail.aliyun.com (out20-13.mail.aliyun.com [115.124.20.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193A17A99
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 18:23:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04466105|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.313447-0.000180101-0.686373;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OgKqA2P_1659057802;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OgKqA2P_1659057802)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 09:23:23 +0800
Date:   Fri, 29 Jul 2022 09:23:24 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
In-Reply-To: <20220726170802.GF13489@twin.jikos.cz>
References: <20220726062537.D2E7.409509F4@e16-tech.com> <20220726170802.GF13489@twin.jikos.cz>
Message-Id: <20220729092323.995A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_62E334D0000000009957_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------_62E334D0000000009957_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

I tried to fold my fix/comment into the attachement file(folded.patch).

Just the following is new, others are just orig feature or refactor.

+	if(ctl->max_stripe_size > ctl->max_chunk_size)
+		ctl->max_stripe_size = ctl->max_chunk_size;

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/29

> On Tue, Jul 26, 2022 at 06:25:38AM +0800, Wang Yugui wrote:
> > > On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> > > > In this patch, the max chunk size is changed from 
> > > > BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
> > > 
> > > The patch hasn't been merged, the change from 1G to 10G without proper
> > > evaluation won't happen. The sysfs knob is available for users who want
> > > to test it or know that the non-default value works in their
> > > environment.
> > 
> > this patch is in misc-next( 5.19.0-rc8 based, 5.19.0-rc7 based) now.
> > 
> > 5.19.0-rc8 based:
> > f6fca3917b4d btrfs: store chunk size in space-info struct
> >
> > The sysfs knob show that current default chunk size is 1G, not 10G as
> > older version.
> 
> So there are two things regarding chunk size, the default size and that
> it's settable by user (with some limitations). I was replying to the
> default size change while you are concerned about the max_chunk_size.
> 
> You're right that the value changed in the patch, but as I'm reading the
> code it should not have any effect. When user sets a value in
> btrfs_chunk_size_store() it's limited inside the sysfs handler to the
> 10G. Also there are various adjustments when the chunk size is
> initialized (init_alloc_chunk_ctl_policy_regular).
> 
> The only difference I can see comparing master and misc-next is in
> decide_stripe_size_regular()
> 
> 5259         /*
> 5260          * Use the number of data stripes to figure out how big this chunk is
> 5261          * really going to be in terms of logical address space, and compare
> 5262          * that answer with the max chunk size. If it's higher, we try to
> 5263          * reduce stripe_size.
> 5264          */
> 5265         if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> ^^^^
> 5266                 /*
> 5267                  * Reduce stripe_size, round it up to a 16MB boundary again and
> 5268                  * then use it, unless it ends up being even bigger than the
> 5269                  * previous value we had already.
> 5270                  */
> 5271                 ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
> 5272                                                         data_stripes), SZ_16M),
> 5273                                        ctl->stripe_size);
> 5274         }
> 
> Here it could lead to a different stripe_size when max_chunk_size would
> be 1G vs 10G, though the other adjustments could change the upper value.


--------_62E334D0000000009957_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="folded.patch"
Content-Disposition: attachment;
 filename="folded.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8u
YwppbmRleCAyY2Y4ZGExMTE2ZWIuLmJmZTg4NGYxMzkzNCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMv
c3BhY2UtaW5mby5jCisrKyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uYwpAQCAtMTg3LDYgKzE4Nywx
NSBAQCB2b2lkIGJ0cmZzX2NsZWFyX3NwYWNlX2luZm9fZnVsbChzdHJ1Y3QgYnRyZnNfZnNfaW5m
byAqaW5mbykKICAqLwogI2RlZmluZSBCVFJGU19ERUZBVUxUX1pPTkVEX1JFQ0xBSU1fVEhSRVNI
CQkJKDc1KQogCisvKgorICogVXBkYXRlIGRlZmF1bHQgY2h1bmsgc2l6ZS4KKyAqLwordm9pZCBi
dHJmc191cGRhdGVfc3BhY2VfaW5mb19jaHVua19zaXplKHN0cnVjdCBidHJmc19zcGFjZV9pbmZv
ICpzcGFjZV9pbmZvLAorCQkJCQl1NjQgY2h1bmtfc2l6ZSkKK3sKKwlXUklURV9PTkNFKHNwYWNl
X2luZm8tPmNodW5rX3NpemUsIGNodW5rX3NpemUpOworfQorCiBzdGF0aWMgaW50IGNyZWF0ZV9z
cGFjZV9pbmZvKHN0cnVjdCBidHJmc19mc19pbmZvICppbmZvLCB1NjQgZmxhZ3MpCiB7CiAKZGlm
ZiAtLWdpdCBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uaCBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uaApp
bmRleCBjMDk2Njk1NTk4YzEuLmU3ZGUyNGE1MjljZiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvc3Bh
Y2UtaW5mby5oCisrKyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uaApAQCAtMjUsNiArMjUsOCBAQCBz
dHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyB7CiAJdTY0IG1heF9leHRlbnRfc2l6ZTsJLyogVGhpcyB3
aWxsIGhvbGQgdGhlIG1heGltdW0gZXh0ZW50IHNpemUgb2YKIAkJCQkgICB0aGUgc3BhY2UgaW5m
byBpZiB3ZSBoYWQgYW4gRU5PU1BDIGluIHRoZQogCQkJCSAgIGFsbG9jYXRvci4gKi8KKwkvKiBD
aHVuayBzaXplIGluIGJ5dGVzICovCisJdTY0IGNodW5rX3NpemU7CiAKIAkvKgogCSAqIE9uY2Ug
YSBibG9jayBncm91cCBkcm9wcyBiZWxvdyB0aGlzIHRocmVzaG9sZCAocGVyY2VudHMpIHdlJ2xs
CkBAIC0xMjMsNiArMTI1LDggQEAgdm9pZCBidHJmc191cGRhdGVfc3BhY2VfaW5mbyhzdHJ1Y3Qg
YnRyZnNfZnNfaW5mbyAqaW5mbywgdTY0IGZsYWdzLAogCQkJICAgICB1NjQgdG90YWxfYnl0ZXMs
IHU2NCBieXRlc191c2VkLAogCQkJICAgICB1NjQgYnl0ZXNfcmVhZG9ubHksIHU2NCBieXRlc196
b25lX3VudXNhYmxlLAogCQkJICAgICBzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqKnNwYWNlX2lu
Zm8pOwordm9pZCBidHJmc191cGRhdGVfc3BhY2VfaW5mb19jaHVua19zaXplKHN0cnVjdCBidHJm
c19zcGFjZV9pbmZvICpzcGFjZV9pbmZvLAorCQkJCQl1NjQgY2h1bmtfc2l6ZSk7CiBzdHJ1Y3Qg
YnRyZnNfc3BhY2VfaW5mbyAqYnRyZnNfZmluZF9zcGFjZV9pbmZvKHN0cnVjdCBidHJmc19mc19p
bmZvICppbmZvLAogCQkJCQkgICAgICAgdTY0IGZsYWdzKTsKIHU2NCBfX3B1cmUgYnRyZnNfc3Bh
Y2VfaW5mb191c2VkKHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzX2luZm8sCmRpZmYgLS1naXQg
YS9mcy9idHJmcy92b2x1bWVzLmMgYi9mcy9idHJmcy92b2x1bWVzLmMKaW5kZXggYTJiYjA5Mjhk
YzA2Li5iN2I3ZDI1NGVjZjAgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYworKysgYi9m
cy9idHJmcy92b2x1bWVzLmMKQEAgLTUwNzIsNiArNTA3Miw3IEBAIHN0YXRpYyB2b2lkIGluaXRf
YWxsb2NfY2h1bmtfY3RsX3BvbGljeV9yZWd1bGFyKAogCQkJCXN0cnVjdCBhbGxvY19jaHVua19j
dGwgKmN0bCkKIHsKIAl1NjQgdHlwZSA9IGN0bC0+dHlwZTsKKwlzdHJ1Y3QgYnRyZnNfc3BhY2Vf
aW5mbyAqc3BhY2VfaW5mbzsKIAogCWlmICh0eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfREFUQSkg
ewogCQljdGwtPm1heF9zdHJpcGVfc2l6ZSA9IFNaXzFHOwpAQCAtNTA5NSw3ICs1MDk2LDE3IEBA
IHN0YXRpYyB2b2lkIGluaXRfYWxsb2NfY2h1bmtfY3RsX3BvbGljeV9yZWd1bGFyKAogCS8qIFdl
IGRvbid0IHdhbnQgYSBjaHVuayBsYXJnZXIgdGhhbiAxMCUgb2Ygd3JpdGFibGUgc3BhY2UgKi8K
IAljdGwtPm1heF9jaHVua19zaXplID0gbWluKGRpdl9mYWN0b3IoZnNfZGV2aWNlcy0+dG90YWxf
cndfYnl0ZXMsIDEpLAogCQkJCSAgY3RsLT5tYXhfY2h1bmtfc2l6ZSk7CisJaWYoY3RsLT5tYXhf
c3RyaXBlX3NpemUgPiBjdGwtPm1heF9jaHVua19zaXplKQorCQljdGwtPm1heF9zdHJpcGVfc2l6
ZSA9IGN0bC0+bWF4X2NodW5rX3NpemU7CisKIAljdGwtPmRldl9leHRlbnRfbWluID0gQlRSRlNf
U1RSSVBFX0xFTiAqIGN0bC0+ZGV2X3N0cmlwZXM7CisKKwlpZiAoY3RsLT50eXBlICYgQlRSRlNf
QkxPQ0tfR1JPVVBfU1lTVEVNKQorCQljdGwtPmRldnNfbWF4ID0gbWluX3QoaW50LCBjdGwtPmRl
dnNfbWF4LCBCVFJGU19NQVhfREVWU19TWVNfQ0hVTkspOworCisJc3BhY2VfaW5mbyA9IGJ0cmZz
X2ZpbmRfc3BhY2VfaW5mbyhmc19kZXZpY2VzLT5mc19pbmZvLCBjdGwtPnR5cGUpOworCUFTU0VS
VChzcGFjZV9pbmZvKTsKKwlidHJmc191cGRhdGVfc3BhY2VfaW5mb19jaHVua19zaXplKHNwYWNl
X2luZm8sIGN0bC0+bWF4X2NodW5rX3NpemUpOwogfQogCiBzdGF0aWMgdm9pZCBpbml0X2FsbG9j
X2NodW5rX2N0bF9wb2xpY3lfem9uZWQoCkBAIC01MTA4LDYgKzUxMTksNyBAQCBzdGF0aWMgdm9p
ZCBpbml0X2FsbG9jX2NodW5rX2N0bF9wb2xpY3lfem9uZWQoCiAJaW50IG1pbl9kYXRhX3N0cmlw
ZXMgPSAobWluX251bV9zdHJpcGVzIC0gY3RsLT5ucGFyaXR5KSAvIGN0bC0+bmNvcGllczsKIAl1
NjQgbWluX2NodW5rX3NpemUgPSBtaW5fZGF0YV9zdHJpcGVzICogem9uZV9zaXplOwogCXU2NCB0
eXBlID0gY3RsLT50eXBlOworCXN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvOwog
CiAJY3RsLT5tYXhfc3RyaXBlX3NpemUgPSB6b25lX3NpemU7CiAJaWYgKHR5cGUgJiBCVFJGU19C
TE9DS19HUk9VUF9EQVRBKSB7CkBAIC01MTI5LDYgKzUxNDEsMTAgQEAgc3RhdGljIHZvaWQgaW5p
dF9hbGxvY19jaHVua19jdGxfcG9saWN5X3pvbmVkKAogCQkgICAgbWluX2NodW5rX3NpemUpOwog
CWN0bC0+bWF4X2NodW5rX3NpemUgPSBtaW4obGltaXQsIGN0bC0+bWF4X2NodW5rX3NpemUpOwog
CWN0bC0+ZGV2X2V4dGVudF9taW4gPSB6b25lX3NpemUgKiBjdGwtPmRldl9zdHJpcGVzOworCisJ
c3BhY2VfaW5mbyA9IGJ0cmZzX2ZpbmRfc3BhY2VfaW5mbyhmc19kZXZpY2VzLT5mc19pbmZvLCBj
dGwtPnR5cGUpOworCUFTU0VSVChzcGFjZV9pbmZvKTsKKwlidHJmc191cGRhdGVfc3BhY2VfaW5m
b19jaHVua19zaXplKHNwYWNlX2luZm8sIGN0bC0+bWF4X2NodW5rX3NpemUpOwogfQogCiBzdGF0
aWMgdm9pZCBpbml0X2FsbG9jX2NodW5rX2N0bChzdHJ1Y3QgYnRyZnNfZnNfZGV2aWNlcyAqZnNf
ZGV2aWNlcywK
--------_62E334D0000000009957_MULTIPART_MIXED_--

