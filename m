Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472F7584A1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 05:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiG2DOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 23:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiG2DOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 23:14:34 -0400
Received: from out20-39.mail.aliyun.com (out20-39.mail.aliyun.com [115.124.20.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B7F7C192
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 20:14:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04442281|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.271367-8.16379e-05-0.728552;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.OgQciPe_1659064439;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OgQciPe_1659064439)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 11:13:59 +0800
Date:   Fri, 29 Jul 2022 11:14:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
In-Reply-To: <20220729100530.32AB.409509F4@e16-tech.com>
References: <20220729092323.995A.409509F4@e16-tech.com> <20220729100530.32AB.409509F4@e16-tech.com>
Message-Id: <20220729111400.658E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------_62E35012000000006589_MULTIPART_MIXED_"
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

--------_62E35012000000006589_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

attachement file(folded-v3.patch):

changes since v2:
   move the caller of btrfs_update_space_info_chunk_size() into init_alloc_chunk_ctl();
   drop the added check of BTRFS_MAX_DEVS_SYS_CHUNK,  that check is already done

changes since v1:
   move ASSERT(space_info) into btrfs_update_space_info_chunk_size();

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/29

> Hi,
> 
> attachement file(folded-v2.patch):
> 
> changes:
>    move ASSERT(space_info) into btrfs_update_space_info_chunk_size();
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/29
> 
> > Hi,
> > 
> > I tried to fold my fix/comment into the attachement file(folded.patch).
> > 
> > Just the following is new, others are just orig feature or refactor.
> > 
> > +	if(ctl->max_stripe_size > ctl->max_chunk_size)
> > +		ctl->max_stripe_size = ctl->max_chunk_size;
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2022/07/29
> > 
> > > On Tue, Jul 26, 2022 at 06:25:38AM +0800, Wang Yugui wrote:
> > > > > On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> > > > > > In this patch, the max chunk size is changed from 
> > > > > > BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?
> > > > > 
> > > > > The patch hasn't been merged, the change from 1G to 10G without proper
> > > > > evaluation won't happen. The sysfs knob is available for users who want
> > > > > to test it or know that the non-default value works in their
> > > > > environment.
> > > > 
> > > > this patch is in misc-next( 5.19.0-rc8 based, 5.19.0-rc7 based) now.
> > > > 
> > > > 5.19.0-rc8 based:
> > > > f6fca3917b4d btrfs: store chunk size in space-info struct
> > > >
> > > > The sysfs knob show that current default chunk size is 1G, not 10G as
> > > > older version.
> > > 
> > > So there are two things regarding chunk size, the default size and that
> > > it's settable by user (with some limitations). I was replying to the
> > > default size change while you are concerned about the max_chunk_size.
> > > 
> > > You're right that the value changed in the patch, but as I'm reading the
> > > code it should not have any effect. When user sets a value in
> > > btrfs_chunk_size_store() it's limited inside the sysfs handler to the
> > > 10G. Also there are various adjustments when the chunk size is
> > > initialized (init_alloc_chunk_ctl_policy_regular).
> > > 
> > > The only difference I can see comparing master and misc-next is in
> > > decide_stripe_size_regular()
> > > 
> > > 5259         /*
> > > 5260          * Use the number of data stripes to figure out how big this chunk is
> > > 5261          * really going to be in terms of logical address space, and compare
> > > 5262          * that answer with the max chunk size. If it's higher, we try to
> > > 5263          * reduce stripe_size.
> > > 5264          */
> > > 5265         if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> > > ^^^^
> > > 5266                 /*
> > > 5267                  * Reduce stripe_size, round it up to a 16MB boundary again and
> > > 5268                  * then use it, unless it ends up being even bigger than the
> > > 5269                  * previous value we had already.
> > > 5270                  */
> > > 5271                 ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
> > > 5272                                                         data_stripes), SZ_16M),
> > > 5273                                        ctl->stripe_size);
> > > 5274         }
> > > 
> > > Here it could lead to a different stripe_size when max_chunk_size would
> > > be 1G vs 10G, though the other adjustments could change the upper value.
> > 
> 


--------_62E35012000000006589_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="folded-v3.patch"
Content-Disposition: attachment;
 filename="folded-v3.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uYyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8u
YwppbmRleCAyZGQ4NzU0Y2I5OTAuLmYzOWU1NTgwN2FiYiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMv
c3BhY2UtaW5mby5jCisrKyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8uYwpAQCAtMTg3LDYgKzE4Nywx
NiBAQCB2b2lkIGJ0cmZzX2NsZWFyX3NwYWNlX2luZm9fZnVsbChzdHJ1Y3QgYnRyZnNfZnNfaW5m
byAqaW5mbykKICAqLwogI2RlZmluZSBCVFJGU19ERUZBVUxUX1pPTkVEX1JFQ0xBSU1fVEhSRVNI
CQkJKDc1KQogCisvKgorICogVXBkYXRlIGRlZmF1bHQgY2h1bmsgc2l6ZS4KKyAqLwordm9pZCBi
dHJmc191cGRhdGVfc3BhY2VfaW5mb19jaHVua19zaXplKHN0cnVjdCBidHJmc19zcGFjZV9pbmZv
ICpzcGFjZV9pbmZvLAorCQkJCQl1NjQgY2h1bmtfc2l6ZSkKK3sKKwlBU1NFUlQoc3BhY2VfaW5m
byk7CisJV1JJVEVfT05DRShzcGFjZV9pbmZvLT5jaHVua19zaXplLCBjaHVua19zaXplKTsKK30K
Kwogc3RhdGljIGludCBjcmVhdGVfc3BhY2VfaW5mbyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqaW5m
bywgdTY0IGZsYWdzKQogewogCmRpZmYgLS1naXQgYS9mcy9idHJmcy9zcGFjZS1pbmZvLmggYi9m
cy9idHJmcy9zcGFjZS1pbmZvLmgKaW5kZXggYzA5NjY5NTU5OGMxLi5lN2RlMjRhNTI5Y2YgMTAw
NjQ0Ci0tLSBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uaAorKysgYi9mcy9idHJmcy9zcGFjZS1pbmZv
LmgKQEAgLTI1LDYgKzI1LDggQEAgc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gewogCXU2NCBtYXhf
ZXh0ZW50X3NpemU7CS8qIFRoaXMgd2lsbCBob2xkIHRoZSBtYXhpbXVtIGV4dGVudCBzaXplIG9m
CiAJCQkJICAgdGhlIHNwYWNlIGluZm8gaWYgd2UgaGFkIGFuIEVOT1NQQyBpbiB0aGUKIAkJCQkg
ICBhbGxvY2F0b3IuICovCisJLyogQ2h1bmsgc2l6ZSBpbiBieXRlcyAqLworCXU2NCBjaHVua19z
aXplOwogCiAJLyoKIAkgKiBPbmNlIGEgYmxvY2sgZ3JvdXAgZHJvcHMgYmVsb3cgdGhpcyB0aHJl
c2hvbGQgKHBlcmNlbnRzKSB3ZSdsbApAQCAtMTIzLDYgKzEyNSw4IEBAIHZvaWQgYnRyZnNfdXBk
YXRlX3NwYWNlX2luZm8oc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmluZm8sIHU2NCBmbGFncywKIAkJ
CSAgICAgdTY0IHRvdGFsX2J5dGVzLCB1NjQgYnl0ZXNfdXNlZCwKIAkJCSAgICAgdTY0IGJ5dGVz
X3JlYWRvbmx5LCB1NjQgYnl0ZXNfem9uZV91bnVzYWJsZSwKIAkJCSAgICAgc3RydWN0IGJ0cmZz
X3NwYWNlX2luZm8gKipzcGFjZV9pbmZvKTsKK3ZvaWQgYnRyZnNfdXBkYXRlX3NwYWNlX2luZm9f
Y2h1bmtfc2l6ZShzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqc3BhY2VfaW5mbywKKwkJCQkJdTY0
IGNodW5rX3NpemUpOwogc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKmJ0cmZzX2ZpbmRfc3BhY2Vf
aW5mbyhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqaW5mbywKIAkJCQkJICAgICAgIHU2NCBmbGFncyk7
CiB1NjQgX19wdXJlIGJ0cmZzX3NwYWNlX2luZm9fdXNlZChzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5m
byAqc19pbmZvLApkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMvdm9s
dW1lcy5jCmluZGV4IDljMjAwNDlkMWZlYy4uOWU3YWM2ZTNmMDI4IDEwMDY0NAotLS0gYS9mcy9i
dHJmcy92b2x1bWVzLmMKKysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jCkBAIC01MDk1LDYgKzUwOTUs
OCBAQCBzdGF0aWMgdm9pZCBpbml0X2FsbG9jX2NodW5rX2N0bF9wb2xpY3lfcmVndWxhcigKIAkv
KiBXZSBkb24ndCB3YW50IGEgY2h1bmsgbGFyZ2VyIHRoYW4gMTAlIG9mIHdyaXRhYmxlIHNwYWNl
ICovCiAJY3RsLT5tYXhfY2h1bmtfc2l6ZSA9IG1pbihkaXZfZmFjdG9yKGZzX2RldmljZXMtPnRv
dGFsX3J3X2J5dGVzLCAxKSwKIAkJCQkgIGN0bC0+bWF4X2NodW5rX3NpemUpOworCWN0bC0+bWF4
X3N0cmlwZV9zaXplID0gbWluKGN0bC0+bWF4X3N0cmlwZV9zaXplLCBjdGwtPm1heF9jaHVua19z
aXplKTsKKwogCWN0bC0+ZGV2X2V4dGVudF9taW4gPSBCVFJGU19TVFJJUEVfTEVOICogY3RsLT5k
ZXZfc3RyaXBlczsKIH0KIApAQCAtNTEyOCw2ICs1MTMwLDggQEAgc3RhdGljIHZvaWQgaW5pdF9h
bGxvY19jaHVua19jdGxfcG9saWN5X3pvbmVkKAogCQkJICAgICAgIHpvbmVfc2l6ZSksCiAJCSAg
ICBtaW5fY2h1bmtfc2l6ZSk7CiAJY3RsLT5tYXhfY2h1bmtfc2l6ZSA9IG1pbihsaW1pdCwgY3Rs
LT5tYXhfY2h1bmtfc2l6ZSk7CisJQVNTRVJUKGN0bC0+bWF4X3N0cmlwZV9zaXplIDw9IGN0bC0+
bWF4X2NodW5rX3NpemUpOworCiAJY3RsLT5kZXZfZXh0ZW50X21pbiA9IHpvbmVfc2l6ZSAqIGN0
bC0+ZGV2X3N0cmlwZXM7CiB9CiAKQEAgLTUxMzUsNiArNTEzOSw3IEBAIHN0YXRpYyB2b2lkIGlu
aXRfYWxsb2NfY2h1bmtfY3RsKHN0cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2VzLAog
CQkJCSBzdHJ1Y3QgYWxsb2NfY2h1bmtfY3RsICpjdGwpCiB7CiAJaW50IGluZGV4ID0gYnRyZnNf
YmdfZmxhZ3NfdG9fcmFpZF9pbmRleChjdGwtPnR5cGUpOworCXN0cnVjdCBidHJmc19zcGFjZV9p
bmZvICpzcGFjZV9pbmZvOwogCiAJY3RsLT5zdWJfc3RyaXBlcyA9IGJ0cmZzX3JhaWRfYXJyYXlb
aW5kZXhdLnN1Yl9zdHJpcGVzOwogCWN0bC0+ZGV2X3N0cmlwZXMgPSBidHJmc19yYWlkX2FycmF5
W2luZGV4XS5kZXZfc3RyaXBlczsKQEAgLTUxNTcsNiArNTE2Miw5IEBAIHN0YXRpYyB2b2lkIGlu
aXRfYWxsb2NfY2h1bmtfY3RsKHN0cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2VzLAog
CWRlZmF1bHQ6CiAJCUJVRygpOwogCX0KKworCXNwYWNlX2luZm8gPSBidHJmc19maW5kX3NwYWNl
X2luZm8oZnNfZGV2aWNlcy0+ZnNfaW5mbywgY3RsLT50eXBlKTsKKwlidHJmc191cGRhdGVfc3Bh
Y2VfaW5mb19jaHVua19zaXplKHNwYWNlX2luZm8sIGN0bC0+bWF4X2NodW5rX3NpemUpOwogfQog
CiBzdGF0aWMgaW50IGdhdGhlcl9kZXZpY2VfaW5mbyhzdHJ1Y3QgYnRyZnNfZnNfZGV2aWNlcyAq
ZnNfZGV2aWNlcywK
--------_62E35012000000006589_MULTIPART_MIXED_--

