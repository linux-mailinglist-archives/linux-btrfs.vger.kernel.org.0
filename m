Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9765674C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 06:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiL0FOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 00:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiL0FOD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 00:14:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E0725F6;
        Mon, 26 Dec 2022 21:14:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1pMYxq2Xb8-00VPPW; Tue, 27
 Dec 2022 06:13:57 +0100
Content-Type: multipart/mixed; boundary="------------ENQBTkI975Siu72IN5GNSZpk"
Message-ID: <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
Date:   Tue, 27 Dec 2022 13:13:52 +0800
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
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
 <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
X-Provags-ID: V03:K1:qdf9hFidGub2Z+Xt3aVh+ueGVwk5Snvl/nbRjHJHdLgaxnT1EVT
 oQXPrS8tE0FjJ4alWPLPEsuWjqhwje1XXc4A1Y4HVRUh3uhk/BgeqgoGJ7NjRWJOKcdICoK
 jwR2DkfOrL6ETN7LwMQLj8loRcFTRNMgkTJwTQoEugaqfq4X9h3L2Q0/ZDJDxolRfV7Tb0o
 hv63P61dlyVlhJe+ziRKA==
UI-OutboundReport: notjunk:1;M01:P0:bAv+bFMv33g=;4G/L+s5MmbNuLFii5TbQaNLihit
 L67Y1yS55GsmZCR7wJOqbeGbECcI0gkgZ/xeppzO6d85J7mw1WVruQA8K0MuNWV7Ma3oTg0iz
 pcKhuIPwJmzXS0YnyEPJ6dB1feIOx+7l+zNInT4211rftjnC8O2YrB7mzcheSRz84G/PhtOFY
 wJK1PQ5tk5+AZPxGhfm6eMg0ugVnU4GmfeJuI9nyXP53Sn3+vLxUsEt+4LHBQYXb89AZ1RcWb
 ly0B4J8C99Gqbwd42zBaVTH9pC63rRlmD8SjQi+tIP5COI8haBWz/xFhRsgl5O3st4yvEOORk
 mI/ZxaWLm7BKT7Jkx0wKIovNHcqr1pTSbasunwMKYbvlvFTCWuCHFY4bQyPp4/+IDjxVFfgP4
 fj9LQ3zV5Y5fCyX7bjtcpWHm24vM2dOIoVOOB9qPvFd0imsaa2qVM9Kq/CbV+jtKWkULBYddZ
 bEHs3xw9z7kjJWyCxZ6JmdQLG2ciYSjBXcxYLHnXaDL95WbyvRy5oWje5yEYcnkOM/21QOcFo
 8TZsbuX9l3iod3YJcYuTRzuuRuXNRW+d4FSKpy45irvkhpru+rNDaXWgdiyJLo/9i1eYYZsUp
 oU+bMAlrnAPzsmb56JcSMXRIznKNPKC0wkRzEEtOwnbaMOKjHpHdUoJHU5PYQ2ub2fgXEBZUe
 0+f0w6RBF+YUL0kR+Yup9bw3kYwp5QA2+v6QCYjZzW8xbyyjyad/nH+SuMRcVhS1GS/B8Yvxm
 5f8GzyQKiL96jpXxdVicL016AAHZaqTXSItyz762uEEZsgKf8G14hjuofRNzjLIgkmdQnhvAo
 nJ5YUnX20CH8ml+W2e2GwWUi9cS2OT8a+SURxR1nNAIMWzp3Hel8opZLNaKgol6xS9fvgW1N5
 XQMuodTQjR4jpSvAbBLDf6NUih9OYJKhfVsiltRUTWNam0AjbjSsLwKpMjw9ilkJOLBXalt2X
 dAdd9+H7z+w8I16ajxuCkSZD51w=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------ENQBTkI975Siu72IN5GNSZpk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/27 09:35, Mikhail Gavrilov wrote:
> On Tue, Dec 27, 2022 at 5:18 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> My bad, missing a ")" in the WARN_ON() line.
>>
>> Fixed with v3 patch.
>>
> 
> New kernel logs are ready.
> 

The result doesn't make sense...

A lot of read_block_for_search() and btrfs_read_node_slot() are 
triggering the warning.

But inside both functions, we have just set the numbers before the call:

In read_block_for_search() we got:

         check.has_first_key = true;
         check.level = parent_level - 1;
         check.transid = gen;
         check.owner_root = root->root_key.objectid;

Thus at least check.has_first_key is always true, and the WARN_ON() 
should never get triggered.
The same applies to btrfs_read_node_slot().

It looks like something involved in memory barrier.

Anyway, the latest debug patch has extra mb to be sure.

And despite the possible fix, could you provide extra info of your 
build? Include:

- Hardware (mostly CPU and RAM spec)
- Toolchain used to compile the kernel (include compiler and its
   version)
- Kernel config

Thanks,
Qu
--------------ENQBTkI975Siu72IN5GNSZpk
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Transfer-Encoding: base64

RnJvbSA5ZDgxYmZlNDgyOTE5NjRlYWY2NThjMDhhNzFmMDRjMzgzOTU5MmQwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OWQ4MWJmZTQ4MjkxOTY0ZWFmNjU4YzA4
YTcxZjA0YzM4Mzk1OTJkMC4xNjcyMTE3OTcwLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDE2OjQ0OjA4
ICswODAwClN1YmplY3Q6IFtQQVRDSCB2NF0gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3Ig
bGV2ZWwgbWlzbWF0Y2gKCkN1cnJlbnRseSBJIGFzc3VtZSB0aGVyZSBpcyBzb21lIHJhY2Ug
b3IgdW5pbml0aWFsaXplZCB2YWx1ZSBmb3IKY2hlY2s6OmxldmVsLgoKVGhlIGV4dHJhIG91
dHB1dCBhcmUgZm9yIHR3byBsb2NhdGlvbnM6CgotIHZhbGlkYXRlX2V4dGVudF9idWZmZXIo
KQogIE91dHB1dCB0aGUgZXJyb3IgbWVzc2FnZSBmb3IgcmVhZCBlcnJvciBhbmQgdGhlIG1l
bWJlcnMgb2YgY2hlY2suCgotIHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcygpCiAgVGhpcyB3
aWxsIGR1bXAgdGhlIHN0YWNrIGZvciB1cyB0byBjYXRjaCB0aGUgb2ZmZW5kZXIuCgpTaWdu
ZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4KLS0tCkNoYW5nZWxvZzoKdjI6
Ci0gRXh0cmEgc3VibWlzc2lvbiB0aW1lIG91dHB1dAogIFRoaXMgd291bGQgZ3JlYXRlbHkg
ZW5sYXJnZSB0aGUgZG1lc2cgc2l6ZQoKLSBFeHRyYSB3YXJuaW5nIHdoZW4gc3VibWl0dGlu
ZyBhIG1ldGFkYXRhIGJpbwogIElmIHdlIGhhdmUgYW4gdW5pbml0aWFsaXplZCBjaGVjayBz
dHJ1Y3R1cmUsIGRvIGEgd2FybmluZyBhbmQgc3RhY2sKICBkdW1wIHRvIHNob3cgdGhlIG9m
ZmVuZGluZyBjYWxsIHRyYWNlLgoKdjM6Ci0gRml4IGEgY29tcGlsaW5nIGVycm9yCgp2NDoK
LSBBZGQgZXh0cmEgbWIgZm9yIHRlc3QKLS0tCiBmcy9idHJmcy9kaXNrLWlvLmMgICB8IDE5
ICsrKysrKysrKysrKysrKysrLS0KIGZzL2J0cmZzL2V4dGVudF9pby5jIHwgMTUgKysrKysr
KysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRyZnMvZGlz
ay1pby5jCmluZGV4IGY4YjU5NTVmMDAzZi4uNDliMDc3YWNmMzU5IDEwMDY0NAotLS0gYS9m
cy9idHJmcy9kaXNrLWlvLmMKKysrIGIvZnMvYnRyZnMvZGlzay1pby5jCkBAIC01MzAsNiAr
NTMwLDEwIEBAIHN0YXRpYyBpbnQgdmFsaWRhdGVfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgZXh0
ZW50X2J1ZmZlciAqZWIsCiAJfQogCiAJaWYgKGZvdW5kX2xldmVsICE9IGNoZWNrLT5sZXZl
bCkgeworCQlidHJmc19lcnIoZWItPmZzX2luZm8sCisibGV2ZWwgdmVyaWZ5IGZhaWxlZCBv
biBsb2dpY2FsICVsbHUgbWlycm9yICV1IHdhbnRlZCAldSBmb3VuZCAldSIsCisJCQkgIGVi
LT5zdGFydCwgZWItPnJlYWRfbWlycm9yLCBjaGVjay0+bGV2ZWwsCisJCQkgIGZvdW5kX2xl
dmVsKTsKIAkJcmV0ID0gLUVJTzsKIAkJZ290byBvdXQ7CiAJfQpAQCAtNTgxLDEzICs1ODUs
MjAgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9leHRlbnRfYnVmZmVyKHN0cnVjdCBleHRlbnRf
YnVmZmVyICplYiwKIAlpZiAoZm91bmRfbGV2ZWwgPiAwICYmIGJ0cmZzX2NoZWNrX25vZGUo
ZWIpKQogCQlyZXQgPSAtRUlPOwogCitvdXQ6CiAJaWYgKCFyZXQpCiAJCXNldF9leHRlbnRf
YnVmZmVyX3VwdG9kYXRlKGViKTsKLQllbHNlCisJZWxzZSB7CiAJCWJ0cmZzX2Vycihmc19p
bmZvLAogCQkicmVhZCB0aW1lIHRyZWUgYmxvY2sgY29ycnVwdGlvbiBkZXRlY3RlZCBvbiBs
b2dpY2FsICVsbHUgbWlycm9yICV1IiwKIAkJCSAgZWItPnN0YXJ0LCBlYi0+cmVhZF9taXJy
b3IpOwotb3V0OgorCQlidHJmc19lcnIoZWItPmZzX2luZm8sCisiY2hlY2sgb3duZXJfcm9v
dD0lbGx1IHRyYW5zaWQ9JWxsdSBmaXJzdF9rZXk9KCVsbHUgJXUgJWxsdSkgaGFzX2ZpcnN0
X2tleT0lZCBsZXZlbD0ldSIsCisJCQkgIGNoZWNrLT5vd25lcl9yb290LAorCQkJICBjaGVj
ay0+dHJhbnNpZCwgY2hlY2stPmZpcnN0X2tleS5vYmplY3RpZCwKKwkJCSAgY2hlY2stPmZp
cnN0X2tleS50eXBlLCBjaGVjay0+Zmlyc3Rfa2V5Lm9mZnNldCwKKwkJCSAgY2hlY2stPmhh
c19maXJzdF9rZXksIGNoZWNrLT5sZXZlbCk7CisJfQogCXJldHVybiByZXQ7CiB9CiAKQEAg
LTY1Miw2ICs2NjMsNyBAQCBpbnQgYnRyZnNfdmFsaWRhdGVfbWV0YWRhdGFfYnVmZmVyKHN0
cnVjdCBidHJmc19iaW8gKmJiaW8sCiAJaW50IHJlYWRzX2RvbmU7CiAKIAlBU1NFUlQocGFn
ZS0+cHJpdmF0ZSk7CisJV0FSTl9PTighYmJpby0+aXNfbWV0YWRhdGEpOwogCiAJaWYgKGJ0
cmZzX3NiKHBhZ2UtPm1hcHBpbmctPmhvc3QtPmlfc2IpLT5ub2Rlc2l6ZSA8IFBBR0VfU0la
RSkKIAkJcmV0dXJuIHZhbGlkYXRlX3N1YnBhZ2VfYnVmZmVyKHBhZ2UsIHN0YXJ0LCBlbmQs
IG1pcnJvciwKQEAgLTgzMywxMiArODQ1LDE1IEBAIHZvaWQgYnRyZnNfc3VibWl0X21ldGFk
YXRhX2JpbyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCBzdHJ1Y3QgYmlvICpiaW8sIGlu
dCBtCiB7CiAJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBpbm9kZS0+cm9vdC0+
ZnNfaW5mbzsKIAlzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvID0gYnRyZnNfYmlvKGJpbyk7CisJ
c3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrIGNoZWNrID0gezB9OwogCWJsa19zdGF0
dXNfdCByZXQ7CiAKIAliaW8tPmJpX29wZiB8PSBSRVFfTUVUQTsKIAliYmlvLT5pc19tZXRh
ZGF0YSA9IDE7CiAKIAlpZiAoYnRyZnNfb3AoYmlvKSAhPSBCVFJGU19NQVBfV1JJVEUpIHsK
KwkJV0FSTl9PTighbWVtY21wKCZjaGVjaywgJmJiaW8tPnBhcmVudF9jaGVjaywKKwkJCXNp
emVvZihzdHJ1Y3QgYnRyZnNfdHJlZV9wYXJlbnRfY2hlY2spKSk7CiAJCWJ0cmZzX3N1Ym1p
dF9iaW8oZnNfaW5mbywgYmlvLCBtaXJyb3JfbnVtKTsKIAkJcmV0dXJuOwogCX0KZGlmZiAt
LWdpdCBhL2ZzL2J0cmZzL2V4dGVudF9pby5jIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMKaW5k
ZXggODNkZDNhYTU5NjYzLi4yOTIwNjQyZGYyYTMgMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL2V4
dGVudF9pby5jCisrKyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jCkBAIC00ODc4LDYgKzQ4Nzgs
NyBAQCBzdGF0aWMgaW50IHJlYWRfZXh0ZW50X2J1ZmZlcl9zdWJwYWdlKHN0cnVjdCBleHRl
bnRfYnVmZmVyICplYiwgaW50IHdhaXQsCiAJCSAqLwogCQlhdG9taWNfZGVjKCZlYi0+aW9f
cGFnZXMpOwogCX0KKwlzbXBfbWIoKTsKIAltZW1jcHkoJmJ0cmZzX2JpbyhiaW9fY3RybC5i
aW8pLT5wYXJlbnRfY2hlY2ssIGNoZWNrLCBzaXplb2YoKmNoZWNrKSk7CiAJc3VibWl0X29u
ZV9iaW8oJmJpb19jdHJsKTsKIAlpZiAocmV0IHx8IHdhaXQgIT0gV0FJVF9DT01QTEVURSkg
ewpAQCAtNDk5Niw2ICs0OTk3LDcgQEAgaW50IHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcyhz
dHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0LCBpbnQgbWlycm9yX251bSwKIAkJ
fQogCX0KIAorCXNtcF9tYigpOwogCW1lbWNweSgmYnRyZnNfYmlvKGJpb19jdHJsLmJpbykt
PnBhcmVudF9jaGVjaywgY2hlY2ssIHNpemVvZigqY2hlY2spKTsKIAlzdWJtaXRfb25lX2Jp
bygmYmlvX2N0cmwpOwogCkBAIC01MDA1LDggKzUwMDcsMTkgQEAgaW50IHJlYWRfZXh0ZW50
X2J1ZmZlcl9wYWdlcyhzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0LCBpbnQg
bWlycm9yX251bSwKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3BhZ2VzOyBpKyspIHsKIAkJcGFn
ZSA9IGViLT5wYWdlc1tpXTsKIAkJd2FpdF9vbl9wYWdlX2xvY2tlZChwYWdlKTsKLQkJaWYg
KCFQYWdlVXB0b2RhdGUocGFnZSkpCisJCWlmICghUGFnZVVwdG9kYXRlKHBhZ2UpKSB7CiAJ
CQlyZXQgPSAtRUlPOworCQkJYnRyZnNfZXJyKGViLT5mc19pbmZvLAorInJlYWQgZmFpbGVk
LCBieXRlbnI9JWxsdSBjaGVjayBvd25lcl9yb290PSVsbHUgdHJhbnNpZD0lbGx1IGhhc19m
aXJzdF9rZXk9JWQgZmlyc3Rfa2V5PSglbGx1ICV1ICVsbHUpIGxldmVsPSV1IiwKKwkJCQkg
IGViLT5zdGFydCwKKwkJCQkgIGNoZWNrLT5vd25lcl9yb290LCBjaGVjay0+dHJhbnNpZCwK
KwkJCQkgIGNoZWNrLT5oYXNfZmlyc3Rfa2V5LAorCQkJCSAgY2hlY2stPmZpcnN0X2tleS5v
YmplY3RpZCwKKwkJCQkgIGNoZWNrLT5maXJzdF9rZXkudHlwZSwKKwkJCQkgIGNoZWNrLT5m
aXJzdF9rZXkub2Zmc2V0LAorCQkJCSAgY2hlY2stPmxldmVsKTsKKwkJCWR1bXBfc3RhY2so
KTsKKwkJfQogCX0KIAogCXJldHVybiByZXQ7Ci0tIAoyLjM5LjAKCg==

--------------ENQBTkI975Siu72IN5GNSZpk--
