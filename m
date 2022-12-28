Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9A65718B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 02:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiL1BI0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 20:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiL1BIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 20:08:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BDE01D;
        Tue, 27 Dec 2022 17:08:23 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1oswAX0SxD-00suDE; Wed, 28
 Dec 2022 02:08:18 +0100
Content-Type: multipart/mixed; boundary="------------E0ZTG6MmySH5MYeAs54wYqcq"
Message-ID: <fd0a0bfe-5c67-fd95-b17c-78a14c63bea6@gmx.com>
Date:   Wed, 28 Dec 2022 09:08:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
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
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
 <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
 <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com>
 <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
X-Provags-ID: V03:K1:EiaBB33Rs1ym9a6AinJLo6BrFr9tBKDFZJeUPW8Rhl14DqHAuZk
 QZVnk35zSa4Wjt0TQxMqw7BJrNBUxZlis2DE8uR7IUJfXq6MUA10X31ETJaw+26IO1yrN9e
 ceE8e7k/6Oy4Nfa2U/EpZER/0Lg+X/+OTsv9y62kRgmLDYx8Ve5s4YrsVEdgCGFMYIvb+nr
 X948XO2lKHDhfIjI+KIcQ==
UI-OutboundReport: notjunk:1;M01:P0:yvsApHdnx5M=;9T9wogz4gd6P/km7leBoKXqcGDw
 JtfCKceClc0kIQQYn9BlIluFacL5MZ2IuYwdxFDkNv9+E/LME7/ReFZShwPwmOGEnnMIfAsPu
 dmmUlbc2e5nO7hdjygYWH5kXRyPGryL7MbpPk7msr7bUpKT4XBVOHGZCKk2/5l/zPyZD+wDGW
 zB+d2lGZnsCwP2RAp/6gku+3iTm1iTT0txCDf96HraDZQzyWcyjKPucGAfXUrdhZC5MYwuf/f
 cUiY3uiyOV3LZ02IaIxRXqyPA4qDQ6/HuzGNmPpZ1KtEjYoyQFXeN9pwE0qCVCm8R6aY9Sfmg
 p9rEVtP4zFZLWsIu0RyvrsYs3jH7WfYvJ5h98/UV0pi7P3urkozQr2sNygPWWj2huBMa3pC18
 zY4103yQ2pcxUAz5pEsRMeLouFK9SIm48oNuYqAE7eueImg0uNwSWxJryTOLydoUqOKbJMjMn
 CTO07x8sFPcZDl+KeG7QxdRtKg6S72lOApwplemhRUsbL26cCdk9VVpSM0/2KBEorU+hxwryq
 a4xtl61E1MP7G5Ii1j4QtDk+axFK9z0SBOct1c4wGLa991ZIzkN2eQJKCfDmCPbH02YoLZpyq
 z6fO73P37MqgeZnso3Dst5XRjgoDb8oXLwrnDK4TtJEQQhnzr6YZg+eWJx/NV5Wzo+VDBRHTi
 n/iZqp4MLVXuDmQiCVL6G/zjBjp7OEf/6smmKI2uQ9d+bsllq5iYZWvwiLD7dMEBadsew9DVO
 2WtckJ/Bf8GdcmnMCZ9ndmv2+aO8oZXhPIg/nVg4T528X1uJC5MCIn+1i2MZQ4tlOSCr+Oalt
 u7hpIhvYCdu+awuASlV2D0JqDhbBZvKEBQNH3GnRsUWTj+sic+vqR8fGOvYBYUBrIsOyYHAc2
 UarF4xFIGKZku46Pa5+dz6RUnVP4Myp4GBrzyU6cDy9WQcMZsEG3YqYR4ANlKuCaE1sM2jOf3
 UU4eLExPQHJMax/6l8Q6/C2ZqFM=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------E0ZTG6MmySH5MYeAs54wYqcq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2022/12/27 21:11, Mikhail Gavrilov wrote:
> On Tue, Dec 27, 2022 at 4:03 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> I have a similar laptop (G14), only GPU is different (RTX3060), and I
>> failed to reproduce this so far...
>>
>> My gcc is only a small version behind (12.2.0).
>>
>> Thus none of the hardware seems suspicious at all...
>>
>> Anyway I have attached my last struggle for the weird problem.
>> For now, I have no idea why this can even happen...
> 
> The new Kernel log is attached.
> This time, the main difference was that the file system did not
> immediately switch to readonly.
> The Steam client stopped a couple of times with a write error, but
> after pressing the resume button, it resumed downloading. For the
> third or fourth time refused to download.
> 
I'm a total idiot.

 From the very first dmesg with calltrack, it already shows the 
submit_one_bio() is called from submit_extent_page(), which means cases 
cross stripe boundary, and has no parent_check populated at all.

And since you're using RAID0 on two NVMEs, it matches the symptom, while 
most tests done here are using single device (DUP and SINGLE), thus no 
stripe boundary cases at all.
(In fact it should still be possible to trigger on SINGLE, but way too 
hard to trigger)

With proper root cause found, this version should mostly handle the 
regression correctly.

This version should mostly be the formal one I'd later send to the 
mailing list.

I can not thank you more for all the testing you have provided, it not 
only pinned down the bug, but also proves I'm a total idiot...

Thanks,
Qu
--------------E0ZTG6MmySH5MYeAs54wYqcq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-fix-the-false-alert-on-bad-tree-level.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-fix-the-false-alert-on-bad-tree-level.patch"
Content-Transfer-Encoding: base64

RnJvbSBjYzA1ZDIyYzA0NTA3NDQwYzY0NDM4NGQzYjY4ZGVmNjU2NTNiMGRlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8Y2MwNWQyMmMwNDUwNzQ0MGM2NDQzODRk
M2I2OGRlZjY1NjUzYjBkZS4xNjcyMTg5NTY4LmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1
IFdlbnJ1byA8d3F1QHN1c2UuY29tPgpEYXRlOiBXZWQsIDI4IERlYyAyMDIyIDA4OjQ0OjE4
ICswODAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IGZpeCB0aGUgZmFsc2UgYWxlcnQgb24g
YmFkIHRyZWUgbGV2ZWwKCltCVUddClRoZXJlIGlzIGEgYnVnIHJlcG9ydCB0aGF0IG9uIGEg
UkFJRDAgbnZtZSBidHJmcyBzeXN0ZW0sIHVuZGVyIGhlYXZ5CndyaXRlIGxvYWQgdGhlIGZz
IGNhbiBmbGlwIFJPIHJhbmRvbWx5LgoKV2l0aCBleHRyYSBkZWJ1ZywgaXQgc2hvd3Mgc29t
ZSB0cmVlIGJsb2NrcyBmYWlsZWQgdG8gcGFzcyBpdHMgbGV2ZWwKY2hlY2tzLCBhbmQgaWYg
dGhhdCBoYXBwZW5zIGF0IGNyaXRpY2FsIHBhdGggb2YgYSB0cmFuc2FjdGlvbiwgd2UgYWJv
cnQKdGhlIHRyYW5zYWNhdGlvbjoKCiBCVFJGUyBlcnJvciAoZGV2aWNlIG52bWUwbjFwMyk6
IGxldmVsIHZlcmlmeSBmYWlsZWQgb24gbG9naWNhbCA1NDQ2MTIxMjA5ODU2IG1pcnJvciAx
IHdhbnRlZCAwIGZvdW5kIDEKIEJUUkZTIGVycm9yIChkZXZpY2UgbnZtZTBuMXAzOiBzdGF0
ZSBBKTogVHJhbnNhY3Rpb24gYWJvcnRlZCAoZXJyb3IgLTUpCiBCVFJGUzogZXJyb3IgKGRl
dmljZSBudm1lMG4xcDM6IHN0YXRlIEEpIGluIGJ0cmZzX2ZpbmlzaF9vcmRlcmVkX2lvOjMz
NDM6IGVycm5vPS01IElPIGZhaWx1cmUKIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xcDM6
IHN0YXRlIEVBKTogZm9yY2VkIHJlYWRvbmx5CgpbQ0FVU0VdClRoZSByZXBvcnRlciBoYXMg
YWxyZWFkeSBiaXNlY3RlZCB0byBjb21taXQgOTQ3YTYyOTk4OGYxICgiYnRyZnM6IG1vdmUK
dHJlZSBibG9jayBwYXJlbnRuZXNzIGNoZWNrIGludG8gdmFsaWRhdGVfZXh0ZW50X2J1ZmZl
cigpIikuCgpBbmQgd2l0aCBleHRyYSBkZWJ1ZywgaXQgc2hvd3Mgd2UgY2FuIGhhdmUgYnRy
ZnNfdHJlZV9wYXJlbnRfY2hlY2sKZmlsbGVkIHdpdGggYWxsIHplcm8gaW4gdGhlIGZvbGxv
d2luZyBjYWxsIHRyYWNlOgoKICA8VEFTSz4KICBzdWJtaXRfb25lX2JpbysweGQ0LzB4ZTAK
ICBzdWJtaXRfZXh0ZW50X3BhZ2UrMHgxNDIvMHg1NTAKICByZWFkX2V4dGVudF9idWZmZXJf
cGFnZXMrMHg1ODQvMHg5YzAKICA/IF9fcGZ4X2VuZF9iaW9fZXh0ZW50X3JlYWRwYWdlKzB4
MTAvMHgxMAogID8gZm9saW9fdW5sb2NrKzB4MWQvMHg1MAogIGJ0cmZzX3JlYWRfZXh0ZW50
X2J1ZmZlcisweDk4LzB4MTUwCiAgcmVhZF90cmVlX2Jsb2NrKzB4NDMvMHhhMAogIHJlYWRf
YmxvY2tfZm9yX3NlYXJjaCsweDI2Ni8weDM3MAogIGJ0cmZzX3NlYXJjaF9zbG90KzB4MzUx
LzB4ZDMwCiAgPyBsb2NrX2lzX2hlbGRfdHlwZSsweGU4LzB4MTQwCiAgYnRyZnNfbG9va3Vw
X2NzdW0rMHg2My8weDE1MAogIGJ0cmZzX2NzdW1fZmlsZV9ibG9ja3MrMHgxOTcvMHg2YzAK
ICA/IHNjaGVkX2Nsb2NrX2NwdSsweDlmLzB4YzAKICA/IGxvY2tfcmVsZWFzZSsweDE0Yi8w
eDQ0MAogID8gX3Jhd19yZWFkX3VubG9jaysweDI5LzB4NTAKICBidHJmc19maW5pc2hfb3Jk
ZXJlZF9pbysweDQ0MS8weDg2MAogIGJ0cmZzX3dvcmtfaGVscGVyKzB4ZmUvMHg0MDAKICA/
IGxvY2tfaXNfaGVsZF90eXBlKzB4ZTgvMHgxNDAKICBwcm9jZXNzX29uZV93b3JrKzB4Mjk0
LzB4NWIwCiAgd29ya2VyX3RocmVhZCsweDRmLzB4M2EwCiAgPyBfX3BmeF93b3JrZXJfdGhy
ZWFkKzB4MTAvMHgxMAogIGt0aHJlYWQrMHhmNS8weDEyMAogID8gX19wZnhfa3RocmVhZCsw
eDEwLzB4MTAKICByZXRfZnJvbV9mb3JrKzB4MmMvMHg1MAogIDwvVEFTSz4KCkN1cnJlbnRs
eSB3ZSBvbmx5IGNvcHkgdGhlIGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrIHN0cnVjdHVyZSBp
bnRvIGJiaW8KYXQgcmVhZF9leHRlbnRfYnVmZmVyX3BhZ2VzKCkgYWZ0ZXIgd2UgaGF2ZSBh
c3NlbWJsZWQgdGhlIGJiaW8uCgpCdXQgYXMgc2hvd24gaW4gdGhlIGFib3ZlIGNhbGwgdHJh
Y2UsIHN1Ym1pdF9leHRlbnRfcGFnZSgpIGl0c2VsZiBjYW4KYWxyZWFkeSBzdWJtaXQgdGhl
IGJiaW8sIGxlYXZpbmcgdGhlIGJiaW8tPnBhcmVudF9jaGVjayB1bmluaXRpYWxpemVkLAph
bmQgY2F1c2UgdGhlIGZhbHNlIGFsZXJ0LgoKW0ZJWF0KSW5zdGVhZCBvZiBjb3B5aW5nIEBj
aGVjayBpbnRvIGJiaW8gYWZ0ZXIgYmJpbyBpcyBhc3NlbWJsZWQsIHdlIHBhc3MKQGNoZWNr
IGluIGJ0cmZzX2Jpb19jdHJsOjpwYXJlbnRfY2hlY2ssIGFuZCBjb3B5IHRoZSBjb250ZW50
IG9mCnBhcmVudF9jaGVjayBpbiBzdWJtaXRfb25lX2JpbygpIGZvciBtZXRhZGF0YSByZWFk
LgoKQnkgdGhpcywgd2Ugc2hvdWxkIGJlIGFibGUgdG8gcGFzcyB0aGUgbmVlZGVkIGluZm8g
Zm9yIG1ldGFkYXRhIGVuZGlvCnZlcmlmaWNhdGlvbiwgYW5kIGZpeCB0aGUgZmFsc2UgYWxl
cnQuCgpSZXBvcnRlZC1ieTogTWlraGFpbCBHYXZyaWxvdiA8bWlraGFpbC52LmdhdnJpbG92
QGdtYWlsLmNvbT4KTGluazogTWlraGFpbCBHYXZyaWxvdiA8bWlraGFpbC52LmdhdnJpbG92
QGdtYWlsLmNvbT4KRml4ZXM6IDk0N2E2Mjk5ODhmMSAoImJ0cmZzOiBtb3ZlIHRyZWUgYmxv
Y2sgcGFyZW50bmVzcyBjaGVjayBpbnRvIHZhbGlkYXRlX2V4dGVudF9idWZmZXIoKSIpClNp
Z25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPgotLS0KIGZzL2J0cmZzL2V4
dGVudF9pby5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvZXh0ZW50X2lvLmMgYi9mcy9idHJmcy9leHRlbnRfaW8uYwppbmRleCA4
M2RkM2FhNTk2NjMuLmIxMTMzMjQ4MmQ1NyAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZXh0ZW50
X2lvLmMKKysrIGIvZnMvYnRyZnMvZXh0ZW50X2lvLmMKQEAgLTEwMyw2ICsxMDMsMTYgQEAg
c3RydWN0IGJ0cmZzX2Jpb19jdHJsIHsKIAl1MzIgbGVuX3RvX29lX2JvdW5kYXJ5OwogCWJ0
cmZzX2Jpb19lbmRfaW9fdCBlbmRfaW9fZnVuYzsKIAorCS8qCisJICogVGhpcyBpcyBmb3Ig
bWV0YWRhdGEgcmVhZCwgdG8gcHJvdmlkZSB0aGUgZXh0cmEgbmVlZGVkCisJICogdmVyaWZp
Y2F0aW9uIGluZm8uCisJICogVGhpcyBoYXMgdG8gYmUgcHJvdmlkZWQgZm9yIHN1Ym1pdF9v
bmVfYmlvKCksIGFzIHN1Ym1pdF9vbmVfYmlvKCkKKwkgKiBjYW4gc3VibWl0IGEgYmlvIGlm
IGl0IGVuZHMgYXQgc3RyaXBlIGJvdW5kYXJ5LgorCSAqIElmIG5vIHN1Y2ggcGFyZW50X2No
ZWNrIHByb3ZpZGVkLCB0aGUgbWV0YWRhdGEgY2FuIGhpdCBmYWxzZSBhbGVydAorCSAqIGF0
IGVuZGlvIHRpbWUuCisJICovCisJc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrICpw
YXJlbnRfY2hlY2s7CisKIAkvKgogCSAqIFRlbGwgd3JpdGVwYWdlIG5vdCB0byBsb2NrIHRo
ZSBzdGF0ZSBiaXRzIGZvciB0aGlzIHJhbmdlLCBpdCBzdGlsbAogCSAqIGRvZXMgdGhlIHVu
bG9ja2luZy4KQEAgLTEzMywxMyArMTQzLDI0IEBAIHN0YXRpYyB2b2lkIHN1Ym1pdF9vbmVf
YmlvKHN0cnVjdCBidHJmc19iaW9fY3RybCAqYmlvX2N0cmwpCiAKIAlidHJmc19iaW8oYmlv
KS0+ZmlsZV9vZmZzZXQgPSBwYWdlX29mZnNldChidi0+YnZfcGFnZSkgKyBidi0+YnZfb2Zm
c2V0OwogCi0JaWYgKCFpc19kYXRhX2lub2RlKCZpbm9kZS0+dmZzX2lub2RlKSkKKwlpZiAo
IWlzX2RhdGFfaW5vZGUoJmlub2RlLT52ZnNfaW5vZGUpKSB7CisJCWlmIChidHJmc19vcChi
aW8pICE9IEJUUkZTX01BUF9XUklURSkgeworCQkJLyoKKwkJCSAqIEZvciBtZXRhZGF0YSBy
ZWFkLCB3ZSBzaG91bGQgaGF2ZSB0aGUgcGFyZW50X2NoZWNrLAorCQkJICogYW5kIGNvcHkg
aXQgdG8gYmJpbyBmb3IgbWV0YWRhdGEgdmVyaWZpY2F0aW9uLgorCQkJICovCisJCQlBU1NF
UlQoYmlvX2N0cmwtPnBhcmVudF9jaGVjayk7CisJCQltZW1jcHkoJmJ0cmZzX2JpbyhiaW8p
LT5wYXJlbnRfY2hlY2ssCisJCQkgICAgICAgYmlvX2N0cmwtPnBhcmVudF9jaGVjaywKKwkJ
CSAgICAgICBzaXplb2Yoc3RydWN0IGJ0cmZzX3RyZWVfcGFyZW50X2NoZWNrKSk7CisJCX0K
IAkJYnRyZnNfc3VibWl0X21ldGFkYXRhX2Jpbyhpbm9kZSwgYmlvLCBtaXJyb3JfbnVtKTsK
LQllbHNlIGlmIChidHJmc19vcChiaW8pID09IEJUUkZTX01BUF9XUklURSkKKwl9IGVsc2Ug
aWYgKGJ0cmZzX29wKGJpbykgPT0gQlRSRlNfTUFQX1dSSVRFKSB7CiAJCWJ0cmZzX3N1Ym1p
dF9kYXRhX3dyaXRlX2Jpbyhpbm9kZSwgYmlvLCBtaXJyb3JfbnVtKTsKLQllbHNlCisJfSBl
bHNlIHsKIAkJYnRyZnNfc3VibWl0X2RhdGFfcmVhZF9iaW8oaW5vZGUsIGJpbywgbWlycm9y
X251bSwKIAkJCQkJICAgYmlvX2N0cmwtPmNvbXByZXNzX3R5cGUpOworCX0KIAogCS8qIFRo
ZSBiaW8gaXMgb3duZWQgYnkgdGhlIGVuZF9pbyBoYW5kbGVyIG5vdyAqLwogCWJpb19jdHJs
LT5iaW8gPSBOVUxMOwpAQCAtNDgyOSw2ICs0ODUwLDcgQEAgc3RhdGljIGludCByZWFkX2V4
dGVudF9idWZmZXJfc3VicGFnZShzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0
LAogCXN0cnVjdCBleHRlbnRfc3RhdGUgKmNhY2hlZF9zdGF0ZSA9IE5VTEw7CiAJc3RydWN0
IGJ0cmZzX2Jpb19jdHJsIGJpb19jdHJsID0gewogCQkubWlycm9yX251bSA9IG1pcnJvcl9u
dW0sCisJCS5wYXJlbnRfY2hlY2sgPSBjaGVjaywKIAl9OwogCWludCByZXQgPSAwOwogCkBA
IC00ODc4LDcgKzQ5MDAsNiBAQCBzdGF0aWMgaW50IHJlYWRfZXh0ZW50X2J1ZmZlcl9zdWJw
YWdlKHN0cnVjdCBleHRlbnRfYnVmZmVyICplYiwgaW50IHdhaXQsCiAJCSAqLwogCQlhdG9t
aWNfZGVjKCZlYi0+aW9fcGFnZXMpOwogCX0KLQltZW1jcHkoJmJ0cmZzX2JpbyhiaW9fY3Ry
bC5iaW8pLT5wYXJlbnRfY2hlY2ssIGNoZWNrLCBzaXplb2YoKmNoZWNrKSk7CiAJc3VibWl0
X29uZV9iaW8oJmJpb19jdHJsKTsKIAlpZiAocmV0IHx8IHdhaXQgIT0gV0FJVF9DT01QTEVU
RSkgewogCQlmcmVlX2V4dGVudF9zdGF0ZShjYWNoZWRfc3RhdGUpOwpAQCAtNDkwNSw2ICs0
OTI2LDcgQEAgaW50IHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcyhzdHJ1Y3QgZXh0ZW50X2J1
ZmZlciAqZWIsIGludCB3YWl0LCBpbnQgbWlycm9yX251bSwKIAl1bnNpZ25lZCBsb25nIG51
bV9yZWFkcyA9IDA7CiAJc3RydWN0IGJ0cmZzX2Jpb19jdHJsIGJpb19jdHJsID0gewogCQku
bWlycm9yX251bSA9IG1pcnJvcl9udW0sCisJCS5wYXJlbnRfY2hlY2sgPSBjaGVjaywKIAl9
OwogCiAJaWYgKHRlc3RfYml0KEVYVEVOVF9CVUZGRVJfVVBUT0RBVEUsICZlYi0+YmZsYWdz
KSkKQEAgLTQ5OTYsNyArNTAxOCw2IEBAIGludCByZWFkX2V4dGVudF9idWZmZXJfcGFnZXMo
c3RydWN0IGV4dGVudF9idWZmZXIgKmViLCBpbnQgd2FpdCwgaW50IG1pcnJvcl9udW0sCiAJ
CX0KIAl9CiAKLQltZW1jcHkoJmJ0cmZzX2JpbyhiaW9fY3RybC5iaW8pLT5wYXJlbnRfY2hl
Y2ssIGNoZWNrLCBzaXplb2YoKmNoZWNrKSk7CiAJc3VibWl0X29uZV9iaW8oJmJpb19jdHJs
KTsKIAogCWlmIChyZXQgfHwgd2FpdCAhPSBXQUlUX0NPTVBMRVRFKQotLSAKMi4zOS4wCgo=


--------------E0ZTG6MmySH5MYeAs54wYqcq--
