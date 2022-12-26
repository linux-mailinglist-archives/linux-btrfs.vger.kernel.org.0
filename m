Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6900D655ED9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 01:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLZAPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 19:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZAPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 19:15:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC01326D6;
        Sun, 25 Dec 2022 16:15:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1ovO7K3o0j-00yxyw; Mon, 26
 Dec 2022 01:15:00 +0100
Content-Type: multipart/mixed; boundary="------------w0nFELUXCPhQHoMhayFHXTjL"
Message-ID: <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com>
Date:   Mon, 26 Dec 2022 08:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, wqu@suse.com,
        dsterba@suse.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
X-Provags-ID: V03:K1:rl63Sb8+oKnUoMrsLi3sD86KHyfaaRKrqR5TrlEUe62piNznXdF
 7G28AxMrENwdUm2J+/dZpHEBNJPb0rg/CQ7A+Vk65XuYuipWlu8qIeLWv9ET9ZcHOekTe1j
 DOWGYmbHjjDecmp+jBxv9dIaxK9rBeLjGYHpv/e1y1WgbKN95sXvmIgAinFXZ8K32ynDQTL
 dqQnpVINBqTUn5Qn+o03A==
UI-OutboundReport: notjunk:1;M01:P0:oqGqgSxTCzw=;AtjxE5VXzmhEwUznBXa1TlZ3VGt
 7ttCdS/NEo0gW1wsl8P0I7vtUe5iZ13vB/dkjr8Xuh9wZXBXIcSlCf5XLKNs+OiLr7FtPtIjW
 JLXH70+CBUWZ9+xvascdxwmFUfuGNotLN9nOS1ruxOKHJg19NMA0b0OHvdfgj1mQaDZ7MYJQv
 r3X/Ff0kCzljjIYTn/vhdxE8YxDMmv+bmvLLGktGYH/h4vl17SCqtL8A5dNDDYjVYj0evEd9E
 qvo9slNYEYujR84YvJ1DT+ec65Flkupen2gcNZCEhwJYoWxVpsxjERiQIzj2Ud0FHS+71NmZP
 b5dOzOCJ9UeFqit5NPZ9a0/kqXGOdQYno0Q4fDNLxDC0aJzT72LxQhDKG0hJqdeq5mrf2y46h
 B7+CaO+Et9i5IZ1UXR9kcrwGpaQSYSFRZwKuZQZtYGpoBUCmv3h3JKzPVoyRjqPhj1oBXQXa7
 Us/kZKc7u/UYhjOfp5N32f11fQR2xAAULcD325D1f/4+7TD+aZyTU4JIzZmRpiqNmnUZSCjsY
 0Okytm6syXJI8yhSAbRLrQ23q7jk8hcIjF4YMkPk9UVouUa9rRMmxOBZO6/8B2jx+8LhUSpWf
 QuESVoiJDQg/o7Jh+SdpPfEaD7eF+luGbNM+zYLb7NuA3/65DqeW1LvzMIFZNJkcN27GPGkaX
 lOHN7EjP2bgAmG0HNGereXlExFBg5nEqCwZiwjL6XZbt2bYgC8Sm+LxQaVBc7VteynrGCBZTT
 2QPy457x+zBq4WqT7I41XufcWnSu3gDsu2mhSOqKjq0Eu+PPoQRgTjO8L5plXvMru8oEqy+Lj
 qo4+tT+oZAd6/1+Otyz3dWEjtEUt7ZUIWNpMKjhcPnN5fnleknwbBND02UvRVzh78BUt61NyS
 sI8FGyrh74OF/GG1ChXKrEtj7FoFs56NxElufoe8tK6fPWQXluvtQlgJMyODWlRUznhHw1GWP
 fSV4x/ajdjiceVUn3XBdmFR/ILM=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------w0nFELUXCPhQHoMhayFHXTjL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/26 05:32, Mikhail Gavrilov wrote:
> Hi,
> It is curious but it happens only on machine which have BTRFS volume
> combined from two high speed nvme (pcie 4) SSD in RAID 0. On machines
> with BTRFS volume from one HDD the bug does not appear.
> 
> To bisect the problematic commit, I had to sweat a lot. At each step,
> I downloaded the 150 GB game "Assassin's Creed Valhalla" 4 times and
> deleted it. For make sure that the commit previous to
> 947a629988f191807d2d22ba63ae18259bb645c5 is definitely not affected by
> the bug, I downloaded this game 10 times, which should have provided
> more than 1.5 Tb of data writing to the btrfs volume.
> 
> Here is result of my bisection:
> 947a629988f191807d2d22ba63ae18259bb645c5 is the first bad commit
> commit 947a629988f191807d2d22ba63ae18259bb645c5
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Wed Sep 14 13:32:51 2022 +0800
> 
>      btrfs: move tree block parentness check into validate_extent_buffer()
> 
[...]
>      Signed-off-by: Qu Wenruo <wqu@suse.com>
>      Signed-off-by: David Sterba <dsterba@suse.com>
> 
>   fs/btrfs/disk-io.c   | 73 ++++++++++++++++++++++++++++++++++++++--------------
>   fs/btrfs/extent_io.c | 18 ++++++++++---
>   fs/btrfs/extent_io.h |  5 ++--
>   fs/btrfs/volumes.h   | 25 +++++++++++++++---
>   4 files changed, 93 insertions(+), 28 deletions(-)
> 
> Before going to readonly, the preceding line in kernel log display a message:
> [ 1908.029663] BTRFS: error (device nvme0n1p3: state A) in
> btrfs_run_delayed_refs:2147: errno=-5 IO failure
> 
> I also attached a full kernel log.
> 
Thanks a lot for the full kernel log.

It indeed shows something is wrong in the run_one_delayed_ref().
But surprisingly, if there is something wrong, I'd expect more output 
from btrfs, as normally if one tree block failed to pass whatever the 
checks, it should cause an error message at least.

Since you can reproduce the bug (although I don't think this is easy to 
reproduce), mind to apply the extra debug patch and then try to reproduce?

(Part of the patch would go upstreamed soon)

Another thing is, mind to run "btrfs check --readonly" on the fs?
I don't believe that's the case, but just in case.

Thanks,
Qu
--------------w0nFELUXCPhQHoMhayFHXTjL
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-run_one_delayed_ref.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-run_one_delayed_ref.patch"
Content-Transfer-Encoding: base64

RnJvbSA0MWNmNzhlNTZlZDJhMzM5MTQ5OTQ2OTg1NWI5MDZkNzRkMDNlZWNhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8NDFjZjc4ZTU2ZWQyYTMzOTE0OTk0Njk4
NTViOTA2ZDc0ZDAzZWVjYS4xNjcyMDEzNDY5LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDA4OjEwOjI3
ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3IgcnVu
X29uZV9kZWxheWVkX3JlZigpCgpTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNl
LmNvbT4KLS0tCiBmcy9idHJmcy9kaXNrLWlvLmMgICAgIHwgIDQgKysrKwogZnMvYnRyZnMv
ZXh0ZW50LXRyZWUuYyB8IDIyICsrKysrKysrKysrKysrKysrKy0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9idHJmcy9kaXNrLWlvLmMgYi9mcy9idHJmcy9kaXNrLWlvLmMKaW5kZXggOGFhN2Q3OWEz
NDFhLi5jNjdjNjg4ZDU2OGUgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2Rpc2staW8uYworKysg
Yi9mcy9idHJmcy9kaXNrLWlvLmMKQEAgLTUzMCw2ICs1MzAsMTAgQEAgc3RhdGljIGludCB2
YWxpZGF0ZV9leHRlbnRfYnVmZmVyKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwKIAl9CiAK
IAlpZiAoZm91bmRfbGV2ZWwgIT0gY2hlY2stPmxldmVsKSB7CisJCWJ0cmZzX2Vycl9ybChl
Yi0+ZnNfaW5mbywKKwkibGV2ZWwgY2hlY2sgZmFpbGVkIG9uIGxvZ2ljYWwgJWxsdSBtaXJy
b3IgJXUgd2FudGVkICV1IGZvdW5kICV1IiwKKwkJCSAgICAgZWItPnN0YXJ0LCBlYi0+cmVh
ZF9taXJyb3IsIGNoZWNrLT5sZXZlbCwKKwkJCSAgICAgZm91bmRfbGV2ZWwpOwogCQlyZXQg
PSAtRUlPOwogCQlnb3RvIG91dDsKIAl9CmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRlbnQt
dHJlZS5jIGIvZnMvYnRyZnMvZXh0ZW50LXRyZWUuYwppbmRleCBlYWExZmIyODUwZDcuLmZl
MWYzMTMxOWQ1OCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZXh0ZW50LXRyZWUuYworKysgYi9m
cy9idHJmcy9leHRlbnQtdHJlZS5jCkBAIC0xNDYyLDggKzE0NjIsMTMgQEAgc3RhdGljIGlu
dCBfX2J0cmZzX2luY19leHRlbnRfcmVmKHN0cnVjdCBidHJmc190cmFuc19oYW5kbGUgKnRy
YW5zLAogCXJldCA9IGluc2VydF9pbmxpbmVfZXh0ZW50X2JhY2tyZWYodHJhbnMsIHBhdGgs
IGJ5dGVuciwgbnVtX2J5dGVzLAogCQkJCQkgICBwYXJlbnQsIHJvb3Rfb2JqZWN0aWQsIG93
bmVyLAogCQkJCQkgICBvZmZzZXQsIHJlZnNfdG9fYWRkLCBleHRlbnRfb3ApOwotCWlmICgo
cmV0IDwgMCAmJiByZXQgIT0gLUVBR0FJTikgfHwgIXJldCkKKwlpZiAoKHJldCA8IDAgJiYg
cmV0ICE9IC1FQUdBSU4pIHx8ICFyZXQpIHsKKwkJaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1F
QUdBSU4pCisJCQlidHJmc19lcnIodHJhbnMtPmZzX2luZm8sCisJCQkJICAiZmFpbGVkIHRv
IGluc2VydCBpbmxpbmUgZXh0ZW50IGJhY2tyZWY6ICVkIiwKKwkJCQkgIHJldCk7CiAJCWdv
dG8gb3V0OworCX0KIAogCS8qCiAJICogT2sgd2UgaGFkIC1FQUdBSU4gd2hpY2ggbWVhbnMg
d2UgZGlkbid0IGhhdmUgc3BhY2UgdG8gaW5zZXJ0IGFuZApAQCAtMTk1NCw4ICsxOTU5LDgg
QEAgc3RhdGljIGludCBidHJmc19ydW5fZGVsYXllZF9yZWZzX2Zvcl9oZWFkKHN0cnVjdCBi
dHJmc190cmFuc19oYW5kbGUgKnRyYW5zLAogCQlpZiAocmV0KSB7CiAJCQl1bnNlbGVjdF9k
ZWxheWVkX3JlZl9oZWFkKGRlbGF5ZWRfcmVmcywgbG9ja2VkX3JlZik7CiAJCQlidHJmc19w
dXRfZGVsYXllZF9yZWYocmVmKTsKLQkJCWJ0cmZzX2RlYnVnKGZzX2luZm8sICJydW5fb25l
X2RlbGF5ZWRfcmVmIHJldHVybmVkICVkIiwKLQkJCQkgICAgcmV0KTsKKwkJCWJ0cmZzX2Vy
cihmc19pbmZvLCAicnVuX29uZV9kZWxheWVkX3JlZiByZXR1cm5lZCAlZCIsCisJCQkJICBy
ZXQpOwogCQkJcmV0dXJuIHJldDsKIAkJfQogCkBAIC00NjQyLDggKzQ2NDcsMTIgQEAgc3Rh
dGljIGludCBhbGxvY19yZXNlcnZlZF9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRs
ZSAqdHJhbnMsIHU2NCBieXRlbnIsCiAJaW50IHJldDsKIAogCXJldCA9IHJlbW92ZV9mcm9t
X2ZyZWVfc3BhY2VfdHJlZSh0cmFucywgYnl0ZW5yLCBudW1fYnl0ZXMpOwotCWlmIChyZXQp
CisJaWYgKHJldCkgeworCQlidHJmc19lcnIoZnNfaW5mbywKKwkiZmFpbGVkIHRvIHJlbW92
ZSBieXRlbnIgJWxsdSBudW1fYnl0ZXMgJWxsdSBmcm9tIGZyZWUgc3BhY2UgdHJlZTogJWQi
LAorCQkJICBieXRlbnIsIG51bV9ieXRlcywgcmV0KTsKIAkJcmV0dXJuIHJldDsKKwl9CiAK
IAlyZXQgPSBidHJmc191cGRhdGVfYmxvY2tfZ3JvdXAodHJhbnMsIGJ5dGVuciwgbnVtX2J5
dGVzLCB0cnVlKTsKIAlpZiAocmV0KSB7CkBAIC00Njg2LDYgKzQ2OTUsOSBAQCBzdGF0aWMg
aW50IGFsbG9jX3Jlc2VydmVkX2ZpbGVfZXh0ZW50KHN0cnVjdCBidHJmc190cmFuc19oYW5k
bGUgKnRyYW5zLAogCWV4dGVudF9yb290ID0gYnRyZnNfZXh0ZW50X3Jvb3QoZnNfaW5mbywg
aW5zLT5vYmplY3RpZCk7CiAJcmV0ID0gYnRyZnNfaW5zZXJ0X2VtcHR5X2l0ZW0odHJhbnMs
IGV4dGVudF9yb290LCBwYXRoLCBpbnMsIHNpemUpOwogCWlmIChyZXQpIHsKKwkJYnRyZnNf
ZXJyKGZzX2luZm8sCisJCQkgICJmYWlsZWQgdG8gaW5zZXJ0IGVtcHR5IGl0ZW0gZm9yIGV4
dGVudCByb290OiAlZCIsCisJCQkgIHJldCk7CiAJCWJ0cmZzX2ZyZWVfcGF0aChwYXRoKTsK
IAkJcmV0dXJuIHJldDsKIAl9CkBAIC00NzU5LDYgKzQ3NzEsOCBAQCBzdGF0aWMgaW50IGFs
bG9jX3Jlc2VydmVkX3RyZWVfYmxvY2soc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJh
bnMsCiAJCQkJICAgICAgc2l6ZSk7CiAJaWYgKHJldCkgewogCQlidHJmc19mcmVlX3BhdGgo
cGF0aCk7CisJCWJ0cmZzX2Vycihmc19pbmZvLCAiZmFpbGVkIHRvIGluc2VydCBlbXB0eSBp
dGVtIGludG8gZXh0ZW50IHJvb3Q6ICVkIiwKKwkJCSAgcmV0KTsKIAkJcmV0dXJuIHJldDsK
IAl9CiAKLS0gCjIuMzkuMAoK

--------------w0nFELUXCPhQHoMhayFHXTjL--
