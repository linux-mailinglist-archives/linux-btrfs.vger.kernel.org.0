Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C62656618
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 00:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiLZXgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 18:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiLZXgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 18:36:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9C2739;
        Mon, 26 Dec 2022 15:36:34 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1os0OS0N9u-00rZ1U; Tue, 27
 Dec 2022 00:36:30 +0100
Content-Type: multipart/mixed; boundary="------------VNsptnCHdvdSTq7fPLuAZ2W6"
Message-ID: <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
Date:   Tue, 27 Dec 2022 07:36:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
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
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
X-Provags-ID: V03:K1:FLFs88oAmIgr+NJ6Rcj+yVorWpBfHVpher7L2Dzdo+e95ilcaeO
 n3d75dV0YvvH9EiMiCA+2NSKRWsNVyZZHMuiXwxOJZ+RocyfbD/g8Ua6S/Uhb4XB09hqayp
 DOy3MO3qS2PjSia99GmsUxooi/hWzNOk2ps3xuaMbRSyKmqeiBvmC/+KUyNFT8yfx8938jf
 +RfjQpYf1zUIw9AZjpcfQ==
UI-OutboundReport: notjunk:1;M01:P0:5bX+sjxueQI=;sqS3BifhxP3SEu37Lfq9iyETwGD
 FZhpMjpEbwhn7GtCf9R1XPO2RnIIQFGsOFv4fmArlT6JryiZya1iWtcSVg9A3qPfW8+Tj0jcs
 RYPVfkKR89yja9F5YTc5XDhy/NVJrH1GoGDJs04kx0SlQKUuyJWhYqrWTy1NqjVEhVn6I/Uea
 gEfOBQ2w7H/kfN385H0kIHC1fje1fPwKgoHidpuBCKMMwOXvHb/D5rs9lvzmIuGKKi8UlxT1l
 E+mwYNSsiXsY1UBQR4nZ60oGi0Hm6BklK6gLJyhD7Um8msqA9J06yrIwaeb7FTvKLJXK7IEDN
 pQl2mvNMjarGA50WftKyiHq1vYYyXKjt3EpuRmj9o/JmwhdkEWf4OiMHTWA83zJMbu4cItH2y
 7h3hvCpYSlqw0SPi/Zr+lW4ALcyva+lI9bSKu5bqqBaweRFexWYFdTfmdKl8ic4IvZVEvqBs2
 byD8VA+ZN/E345p13ZhsE6S8QmKnfFxFoEOpLJrDU8DUVW3mwt+eavCkff2A57lhtzhHqzhvs
 BrYk24KtsxjFPCDabj/XyrdCqSVrufkrIgfH9Zbq2yC+eWRbZEJZOHdXbIl1RzFCEKwo2WN2k
 YtB1xbHv4EPTQDIjNkz80ZxKfzF2kx81gHfsalvUVKdoPvryA/HPILnXGJ1DFMeNideiIw2UQ
 v501Z1fubWP0rqkhRCG5Lf1xYMM2rgZQJXI39ca6JkjXj8FzyZBK2E2hC6WlQLV+Pbn/fLG7A
 0M9ocbrcgPmB9O+MUFEjaz8feTAOWmRBOYwHYfmhCiaV8tlsY9FVUnn1S3LEp2HKn+yzCQJtl
 KoWxAJj0meINvEeMuIOWOc5ykscADN5pP/Bt9HTWNk6YzI8Ij66EFH8yU5zVeuOwKC+DJp80S
 +zpLhMv6ij9d/m+0sV5EB7+gHK7D/nbq5oteljPcnHZNoVJhAXpzSSJkiMEsEUBH3SWL5MasV
 L2VhODWwFVWnv+Gc+pNwMuMAQhE=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------VNsptnCHdvdSTq7fPLuAZ2W6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/26 20:15, Mikhail Gavrilov wrote:
> On Mon, Dec 26, 2022 at 5:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> While at the caller, the structure is properly passed in.
>>
>> So there is something wrong between the endio function and the check.
>>
>> I have created the v2 version patch to debug, please apply without any
>> previous debug patch.
>>
>> Meanwhile this really looks like a race, thus I'm not 100% sure if my
>> debug patch would reduce the possibility to reproduce.
>>
>> Your bisect should be the determining evidence, for the worst case we
>> can revert the offending patch.
>>
>> Thank you very much for all of the testing, it really helps a lot.
>> Qu
>>
> 
> Looks like v2 version patch is missed in last message
> 
Oh, my bad.

Please be aware that, this newer version may cause extra kernel 
warnings, if it found any uninitialized btrfs_tree_parent_check 
structure at submit time.

But there are completely valid cases we can do that, thus it may cause 
much larger dmesg output, and you should not rely on the kernel warning 
to determine if the bug is triggered.

Thanks,
Qu
--------------VNsptnCHdvdSTq7fPLuAZ2W6
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-add-extra-debug-for-level-mismatch.patch"
Content-Transfer-Encoding: base64

RnJvbSAyNzM5Njg2MTBhNDQyNzU1OWY3NDk1OGVkNDU2YTAwZWEwZjVmYzc0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8MjczOTY4NjEwYTQ0Mjc1NTlmNzQ5NThl
ZDQ1NmEwMGVhMGY1ZmM3NC4xNjcyMDk3NTU5LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBNb24sIDI2IERlYyAyMDIyIDE2OjQ0OjA4
ICswODAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gYnRyZnM6IGFkZCBleHRyYSBkZWJ1ZyBmb3Ig
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
ZmVuZGluZyBjYWxsIHRyYWNlLgotLS0KIGZzL2J0cmZzL2Rpc2staW8uYyAgIHwgMTkgKysr
KysrKysrKysrKysrKystLQogZnMvYnRyZnMvZXh0ZW50X2lvLmMgfCAxMyArKysrKysrKysr
KystCiAyIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRyZnMvZGlzay1pby5j
CmluZGV4IGY4YjU5NTVmMDAzZi4uNTAyM2YyMTNhYTUyIDEwMDY0NAotLS0gYS9mcy9idHJm
cy9kaXNrLWlvLmMKKysrIGIvZnMvYnRyZnMvZGlzay1pby5jCkBAIC01MzAsNiArNTMwLDEw
IEBAIHN0YXRpYyBpbnQgdmFsaWRhdGVfZXh0ZW50X2J1ZmZlcihzdHJ1Y3QgZXh0ZW50X2J1
ZmZlciAqZWIsCiAJfQogCiAJaWYgKGZvdW5kX2xldmVsICE9IGNoZWNrLT5sZXZlbCkgewor
CQlidHJmc19lcnIoZWItPmZzX2luZm8sCisibGV2ZWwgdmVyaWZ5IGZhaWxlZCBvbiBsb2dp
Y2FsICVsbHUgbWlycm9yICV1IHdhbnRlZCAldSBmb3VuZCAldSIsCisJCQkgIGViLT5zdGFy
dCwgZWItPnJlYWRfbWlycm9yLCBjaGVjay0+bGV2ZWwsCisJCQkgIGZvdW5kX2xldmVsKTsK
IAkJcmV0ID0gLUVJTzsKIAkJZ290byBvdXQ7CiAJfQpAQCAtNTgxLDEzICs1ODUsMjAgQEAg
c3RhdGljIGludCB2YWxpZGF0ZV9leHRlbnRfYnVmZmVyKHN0cnVjdCBleHRlbnRfYnVmZmVy
ICplYiwKIAlpZiAoZm91bmRfbGV2ZWwgPiAwICYmIGJ0cmZzX2NoZWNrX25vZGUoZWIpKQog
CQlyZXQgPSAtRUlPOwogCitvdXQ6CiAJaWYgKCFyZXQpCiAJCXNldF9leHRlbnRfYnVmZmVy
X3VwdG9kYXRlKGViKTsKLQllbHNlCisJZWxzZSB7CiAJCWJ0cmZzX2Vycihmc19pbmZvLAog
CQkicmVhZCB0aW1lIHRyZWUgYmxvY2sgY29ycnVwdGlvbiBkZXRlY3RlZCBvbiBsb2dpY2Fs
ICVsbHUgbWlycm9yICV1IiwKIAkJCSAgZWItPnN0YXJ0LCBlYi0+cmVhZF9taXJyb3IpOwot
b3V0OgorCQlidHJmc19lcnIoZWItPmZzX2luZm8sCisiY2hlY2sgb3duZXJfcm9vdD0lbGx1
IHRyYW5zaWQ9JWxsdSBmaXJzdF9rZXk9KCVsbHUgJXUgJWxsdSkgaGFzX2ZpcnN0X2tleT0l
ZCBsZXZlbD0ldSIsCisJCQkgIGNoZWNrLT5vd25lcl9yb290LAorCQkJICBjaGVjay0+dHJh
bnNpZCwgY2hlY2stPmZpcnN0X2tleS5vYmplY3RpZCwKKwkJCSAgY2hlY2stPmZpcnN0X2tl
eS50eXBlLCBjaGVjay0+Zmlyc3Rfa2V5Lm9mZnNldCwKKwkJCSAgY2hlY2stPmhhc19maXJz
dF9rZXksIGNoZWNrLT5sZXZlbCk7CisJfQogCXJldHVybiByZXQ7CiB9CiAKQEAgLTY1Miw2
ICs2NjMsNyBAQCBpbnQgYnRyZnNfdmFsaWRhdGVfbWV0YWRhdGFfYnVmZmVyKHN0cnVjdCBi
dHJmc19iaW8gKmJiaW8sCiAJaW50IHJlYWRzX2RvbmU7CiAKIAlBU1NFUlQocGFnZS0+cHJp
dmF0ZSk7CisJV0FSTl9PTighYmJpby0+aXNfbWV0YWRhdGEpOwogCiAJaWYgKGJ0cmZzX3Ni
KHBhZ2UtPm1hcHBpbmctPmhvc3QtPmlfc2IpLT5ub2Rlc2l6ZSA8IFBBR0VfU0laRSkKIAkJ
cmV0dXJuIHZhbGlkYXRlX3N1YnBhZ2VfYnVmZmVyKHBhZ2UsIHN0YXJ0LCBlbmQsIG1pcnJv
ciwKQEAgLTgzMywxMiArODQ1LDE1IEBAIHZvaWQgYnRyZnNfc3VibWl0X21ldGFkYXRhX2Jp
byhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLCBzdHJ1Y3QgYmlvICpiaW8sIGludCBtCiB7
CiAJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBpbm9kZS0+cm9vdC0+ZnNfaW5m
bzsKIAlzdHJ1Y3QgYnRyZnNfYmlvICpiYmlvID0gYnRyZnNfYmlvKGJpbyk7CisJc3RydWN0
IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrIGNoZWNrID0gezB9OwogCWJsa19zdGF0dXNfdCBy
ZXQ7CiAKIAliaW8tPmJpX29wZiB8PSBSRVFfTUVUQTsKIAliYmlvLT5pc19tZXRhZGF0YSA9
IDE7CiAKIAlpZiAoYnRyZnNfb3AoYmlvKSAhPSBCVFJGU19NQVBfV1JJVEUpIHsKKwkJV0FS
Tl9PTighbWVtY21wKCZjaGVjaywgJmJiaW8tPnBhcmVudF9jaGVjaywKKwkJCXNpemVvZihz
dHJ1Y3QgYnRyZnNfdHJlZV9wYXJlbnRfY2hlY2spKTsKIAkJYnRyZnNfc3VibWl0X2Jpbyhm
c19pbmZvLCBiaW8sIG1pcnJvcl9udW0pOwogCQlyZXR1cm47CiAJfQpkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvZXh0ZW50X2lvLmMgYi9mcy9idHJmcy9leHRlbnRfaW8uYwppbmRleCA4M2Rk
M2FhNTk2NjMuLmM5NGViMDM2ZGRlNCAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZXh0ZW50X2lv
LmMKKysrIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMKQEAgLTUwMDUsOCArNTAwNSwxOSBAQCBp
bnQgcmVhZF9leHRlbnRfYnVmZmVyX3BhZ2VzKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwg
aW50IHdhaXQsIGludCBtaXJyb3JfbnVtLAogCWZvciAoaSA9IDA7IGkgPCBudW1fcGFnZXM7
IGkrKykgewogCQlwYWdlID0gZWItPnBhZ2VzW2ldOwogCQl3YWl0X29uX3BhZ2VfbG9ja2Vk
KHBhZ2UpOwotCQlpZiAoIVBhZ2VVcHRvZGF0ZShwYWdlKSkKKwkJaWYgKCFQYWdlVXB0b2Rh
dGUocGFnZSkpIHsKIAkJCXJldCA9IC1FSU87CisJCQlidHJmc19lcnIoZWItPmZzX2luZm8s
CisicmVhZCBmYWlsZWQsIGJ5dGVucj0lbGx1IGNoZWNrIG93bmVyX3Jvb3Q9JWxsdSB0cmFu
c2lkPSVsbHUgaGFzX2ZpcnN0X2tleT0lZCBmaXJzdF9rZXk9KCVsbHUgJXUgJWxsdSkgbGV2
ZWw9JXUiLAorCQkJCSAgZWItPnN0YXJ0LAorCQkJCSAgY2hlY2stPm93bmVyX3Jvb3QsIGNo
ZWNrLT50cmFuc2lkLAorCQkJCSAgY2hlY2stPmhhc19maXJzdF9rZXksCisJCQkJICBjaGVj
ay0+Zmlyc3Rfa2V5Lm9iamVjdGlkLAorCQkJCSAgY2hlY2stPmZpcnN0X2tleS50eXBlLAor
CQkJCSAgY2hlY2stPmZpcnN0X2tleS5vZmZzZXQsCisJCQkJICBjaGVjay0+bGV2ZWwpOwor
CQkJZHVtcF9zdGFjaygpOworCQl9CiAJfQogCiAJcmV0dXJuIHJldDsKLS0gCjIuMzkuMAoK


--------------VNsptnCHdvdSTq7fPLuAZ2W6--
