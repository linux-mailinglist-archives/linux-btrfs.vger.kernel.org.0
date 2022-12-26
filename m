Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B991656146
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 09:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiLZIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 03:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiLZIrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 03:47:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C5103;
        Mon, 26 Dec 2022 00:47:29 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1pRnzT1FT8-00IDmA; Mon, 26
 Dec 2022 09:47:26 +0100
Content-Type: multipart/mixed; boundary="------------ayHqvGI0q04d6op00JQAIbv0"
Message-ID: <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
Date:   Mon, 26 Dec 2022 16:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
 <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com>
 <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
X-Provags-ID: V03:K1:c/o9oxf5gRtPg6nNIODqSNwpQ+WmR5bFK9QrH3IoQgpaCVRNoNY
 fWByYbEuhHTDqsYKdlMnaCqMpFb2TwvouFPnuc4ig3Xm5jr+Y4U3auFGjmniZKTjdTeWGa+
 caHwEMOqQGLqswKUqCGX5qL6wtfJy83SN0Paam+09cS3F6ZiBBbCmgbH6SGN4TSswiRtUwi
 SbMCGxAFWqQw3/kRO3FLQ==
UI-OutboundReport: notjunk:1;M01:P0:w188Ug7Ygos=;nNRh2DrG+NfxJBjYvJ1Aatq8wuj
 +CHWE9YJYA4HIy2tRy5vmZp0f/l42Uev50eZjHpqetbZcSR2h9Z7k5wkB/gDnetLlrW8dc/mx
 FpqusZS8tvhmQSLqNxceMw7StsP1KZ3RtK8JErmty2nPTRNLOWLiMcS/5oo/tMSWicG/XfO1t
 PNekl1HouNXVrZwjDU2Xl3I7Y31dve9mqiuOu0CK3wbQL6ZbbCOCwMXx+3Udj+KwERHaYQ0wm
 vBqu4TZLmM/zeF+N+b7l9KmmY6rZUxHI3wQ/+zYW6QtS5vmgPJpV6N1l1mLyvhHRw7Oxgw5r8
 ESHolmxJoZWyvjL8tpIXZNsb7wgWY6AvXmLu0Ayr4Ot+6+VOYAEb9juF5wW/tGmu0QdcitQtP
 r+KxSHUQemCF7y/7Ljd3MznqAx1Lb9IKWrtUAOtLM/CbdQQn06LxxC8qE3FBLeG0tjqIuZSL8
 6K3gsLhDUjaVYhii60eP2AnaamhETbzXJue855Y7c4JKaO1pY8VUQcvq17HpdOJJrekPIc1WS
 rXvtakBrO7M9rvbmaFKQzmDO9BIZ2aXoaBwuoAYpn8u45j8FNBGk2AMCES0UlTiuAzkLq8AWl
 zliIaD83IxddF5M2F+1ITlvlroSjIcWHlQmoaFhAwqs5geGBj7u341OpcHlJFGa2zh1w6kES2
 pUjWg9F9GTTKDgidI+Vuxwrk8yJbp9Xkh8NesU6KAWMokzfhK0yArOKq8isR5mBLDNJNK8y/w
 bOZkEXh5ZmAy8yzxd/8+MtrGCtFiyUA/MQW6CvGB1iHGmd0ysQQa/Al3O9TjpmuufPF1irHgX
 nllBEK8vuoaNiF8KHKFOyqeOxwkpcwCT/WLNFBtgFdBDT0YKFtZkJAs/5ZAHkOMOHS6NQRof9
 7EPWlBvc1t9UfxFVRlXbqmEBp6jULjXhH6TCbeR1aLgKyH8qltCxz4ov2zOAp1A7mYP33FA05
 bs5AwH+FGdicy52YlBv6xUbGMkc=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------ayHqvGI0q04d6op00JQAIbv0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/26 16:15, Mikhail Gavrilov wrote:
> On Mon, Dec 26, 2022 at 8:29 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> OK, indeed a level mismatch.
>>
>>   From the remaining lines, it shows we're failing at
>> do_free_extent_accounting(), which failed at the btrfs_del_csums().
>>
>> And inside btrfs_del_csums(), what we do are all regular btree
>> operations, thus the tree level check should work without problem.
>>
>> Thus it seems to be a corrupted csum tree.
> 
> Do I need to debug anything else to understand the cause of the error?
> Thanks.

With the check output, it's indeed a runtime error.
(At least no corruption to your fs)

And it can be some call paths not properly initializing the level to check.

Here is the new debug patch.
It should be applied without any previous debug patch.

Thanks,
Qu


> 
>> Could you please run "btrfs check --readonly" from a liveCD?
>> There are tons of possible false alerts if ran on a RW mounted fs.
>>
> 
> # btrfs check --readonly /dev/nvme0n1p3
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p3
> UUID: 40e0b5d2-df54-46e0-b6f4-2f868296271d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 6828416307200 bytes used, no error found
> total csum bytes: 6651838248
> total tree bytes: 16378380288
> total fs tree bytes: 7483179008
> total extent tree bytes: 1228210176
> btree space waste bytes: 2413299694
> file data blocks allocated: 6899999100928
>   referenced 7488299450368
> [root@localhost-live ~]#
> 
> With liveCD looks like all OK (no errors found).
> 
--------------ayHqvGI0q04d6op00JQAIbv0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Transfer-Encoding: base64

RnJvbSBjOTkzMmQ0MDU5NGRhNjA2NTEyNWI3NmI1NWJkOWNlYTFmYWJjODEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8Yzk5MzJkNDA1OTRkYTYwNjUxMjViNzZi
NTViZDljZWExZmFiYzgxMi4xNjcyMDQ0MzkyLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDE2OjQ0OjA4
ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3IgbGV2
ZWwgbWlzbWF0Y2gKCkN1cnJlbnRseSBJIGFzc3VtZSB0aGVyZSBpcyBzb21lIHJhY2Ugb3Ig
dW5pbml0aWFsaXplZCB2YWx1ZSBmb3IKY2hlY2s6OmxldmVsLgoKVGhlIGV4dHJhIG91dHB1
dCBhcmUgZm9yIHR3byBsb2NhdGlvbnM6CgotIHZhbGlkYXRlX2V4dGVudF9idWZmZXIoKQog
IE91dHB1dCB0aGUgZXJyb3IgbWVzc2FnZSBmb3IgcmVhZCBlcnJvciBhbmQgdGhlIG1lbWJl
cnMgb2YgY2hlY2suCgotIHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcygpCiAgVGhpcyB3aWxs
IGR1bXAgdGhlIHN0YWNrIGZvciB1cyB0byBjYXRjaCB0aGUgb2ZmZW5kZXIuCgpTaWduZWQt
b2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4KLS0tCiBmcy9idHJmcy9kaXNrLWlv
LmMgICB8IDE1ICsrKysrKysrKysrKystLQogZnMvYnRyZnMvZXh0ZW50X2lvLmMgfCAxMiAr
KysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy9kaXNrLWlvLmMgYi9mcy9idHJmcy9k
aXNrLWlvLmMKaW5kZXggZjhiNTk1NWYwMDNmLi42MmU2YWQ5MDliMTkgMTAwNjQ0Ci0tLSBh
L2ZzL2J0cmZzL2Rpc2staW8uYworKysgYi9mcy9idHJmcy9kaXNrLWlvLmMKQEAgLTUzMCw2
ICs1MzAsMTAgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9leHRlbnRfYnVmZmVyKHN0cnVjdCBl
eHRlbnRfYnVmZmVyICplYiwKIAl9CiAKIAlpZiAoZm91bmRfbGV2ZWwgIT0gY2hlY2stPmxl
dmVsKSB7CisJCWJ0cmZzX2VycihlYi0+ZnNfaW5mbywKKyJsZXZlbCB2ZXJpZnkgZmFpbGVk
IG9uIGxvZ2ljYWwgJWxsdSBtaXJyb3IgJXUgd2FudGVkICV1IGZvdW5kICV1IiwKKwkJCSAg
ZWItPnN0YXJ0LCBlYi0+cmVhZF9taXJyb3IsIGNoZWNrLT5sZXZlbCwKKwkJCSAgZm91bmRf
bGV2ZWwpOwogCQlyZXQgPSAtRUlPOwogCQlnb3RvIG91dDsKIAl9CkBAIC01ODEsMTMgKzU4
NSwyMCBAQCBzdGF0aWMgaW50IHZhbGlkYXRlX2V4dGVudF9idWZmZXIoc3RydWN0IGV4dGVu
dF9idWZmZXIgKmViLAogCWlmIChmb3VuZF9sZXZlbCA+IDAgJiYgYnRyZnNfY2hlY2tfbm9k
ZShlYikpCiAJCXJldCA9IC1FSU87CiAKK291dDoKIAlpZiAoIXJldCkKIAkJc2V0X2V4dGVu
dF9idWZmZXJfdXB0b2RhdGUoZWIpOwotCWVsc2UKKwllbHNlIHsKIAkJYnRyZnNfZXJyKGZz
X2luZm8sCiAJCSJyZWFkIHRpbWUgdHJlZSBibG9jayBjb3JydXB0aW9uIGRldGVjdGVkIG9u
IGxvZ2ljYWwgJWxsdSBtaXJyb3IgJXUiLAogCQkJICBlYi0+c3RhcnQsIGViLT5yZWFkX21p
cnJvcik7Ci1vdXQ6CisJCWJ0cmZzX2VycihlYi0+ZnNfaW5mbywKKyJjaGVjayBvd25lcl9y
b290PSVsbHUgdHJhbnNpZD0lbGx1IGZpcnN0X2tleT0oJWxsdSAldSAlbGx1KSBoYXNfZmly
c3Rfa2V5PSVkIGxldmVsPSV1IiwKKwkJCSAgY2hlY2stPm93bmVyX3Jvb3QsCisJCQkgIGNo
ZWNrLT50cmFuc2lkLCBjaGVjay0+Zmlyc3Rfa2V5Lm9iamVjdGlkLAorCQkJICBjaGVjay0+
Zmlyc3Rfa2V5LnR5cGUsIGNoZWNrLT5maXJzdF9rZXkub2Zmc2V0LAorCQkJICBjaGVjay0+
aGFzX2ZpcnN0X2tleSwgY2hlY2stPmxldmVsKTsKKwl9CiAJcmV0dXJuIHJldDsKIH0KIApk
aWZmIC0tZ2l0IGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMgYi9mcy9idHJmcy9leHRlbnRfaW8u
YwppbmRleCA4M2RkM2FhNTk2NjMuLjVmMjY3MzQ1ZWY5NCAxMDA2NDQKLS0tIGEvZnMvYnRy
ZnMvZXh0ZW50X2lvLmMKKysrIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMKQEAgLTUwMDUsOCAr
NTAwNSwxOCBAQCBpbnQgcmVhZF9leHRlbnRfYnVmZmVyX3BhZ2VzKHN0cnVjdCBleHRlbnRf
YnVmZmVyICplYiwgaW50IHdhaXQsIGludCBtaXJyb3JfbnVtLAogCWZvciAoaSA9IDA7IGkg
PCBudW1fcGFnZXM7IGkrKykgewogCQlwYWdlID0gZWItPnBhZ2VzW2ldOwogCQl3YWl0X29u
X3BhZ2VfbG9ja2VkKHBhZ2UpOwotCQlpZiAoIVBhZ2VVcHRvZGF0ZShwYWdlKSkKKwkJaWYg
KCFQYWdlVXB0b2RhdGUocGFnZSkpIHsKIAkJCXJldCA9IC1FSU87CisJCQlidHJmc19lcnIo
ZWItPmZzX2luZm8sCisicmVhZCBmYWlsZWQsIGNoZWNrIG93bmVyX3Jvb3Q9JWxsdSB0cmFu
c2lkPSVsbHUgaGFzX2ZpcnN0X2tleT0lZCBmaXJzdF9rZXk9KCVsbHUgJXUgJWxsdSkgbGV2
ZWw9JXUiLAorCQkJCSAgY2hlY2stPm93bmVyX3Jvb3QsIGNoZWNrLT50cmFuc2lkLAorCQkJ
CSAgY2hlY2stPmhhc19maXJzdF9rZXksCisJCQkJICBjaGVjay0+Zmlyc3Rfa2V5Lm9iamVj
dGlkLAorCQkJCSAgY2hlY2stPmZpcnN0X2tleS50eXBlLAorCQkJCSAgY2hlY2stPmZpcnN0
X2tleS5vZmZzZXQsCisJCQkJICBjaGVjay0+bGV2ZWwpOworCQkJZHVtcF9zdGFjaygpOwor
CQl9CiAJfQogCiAJcmV0dXJuIHJldDsKLS0gCjIuMzkuMAoK

--------------ayHqvGI0q04d6op00JQAIbv0--
