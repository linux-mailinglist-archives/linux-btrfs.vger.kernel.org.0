Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A598442480
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhKBALI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 20:11:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:46525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKBALF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Nov 2021 20:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635811708;
        bh=izbGtSmcmOy1xnIRl1KRR6yEi5TJsvbWjVoToJgJ9vs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=QlmxQhmCxs1gfzVRk2v86N9ve62XdYpHlI9TNnw73OsKWsio7+IKDdGidqfa8VARC
         SnHOuwl1HxLFPDhuXoaSgpyLy3XrXsjOLT+qmzmbI6s29SuHRo8r9L+qGLRumWIW/z
         c0DpeM+NS9sqOzG2Hz2rgFLBDoEudu6u1VS5qrVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSbxD-1nAgJn3cj3-00Ssjq; Tue, 02
 Nov 2021 01:08:28 +0100
Content-Type: multipart/mixed; boundary="------------aAj0KYSwQwAzBQ1X7M7n9DPy"
Message-ID: <351dac77-310c-40f5-b9c0-ce7f03f723f9@gmx.com>
Date:   Tue, 2 Nov 2021 08:08:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1635773880.git.dsterba@suse.com>
 <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
In-Reply-To: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
X-Provags-ID: V03:K1:sVjaV9MFVFFLjeNdQLmbaSUrzwY4n3EOmjDWSPHu/+zmEHgT2yS
 +FN0CQPyJ11QSuTsOxEuDflSlLdn7Ga8Yjbg4r46sIY8MZuo5Nm4Tx6SRnBbsCtMZvcsip9
 Jnp4obIYQMEwiYI3lxQtvuOfO0vwRodWNQQtIdOpzw522/PIqp9K3h/jcG8rCcD8/v0h+tg
 FQIkxsDuYfz013F7I7aHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1VYOZSEh05w=:ZoC5MFPdX1tLqf1B2i2mqQ
 4hSsTiwr2dXszb1tPcMTbZCpD3J/dMWYK5VCb8bGc96lbuAUtUvevCGNnl9NZZvr8n6QJ5aRk
 4mAe9/92ICXnSsEFE+KNEZVuPmoPpfc+vZTyni82pKXNx9jENE0eBvOLl6FZ6kMNTBelhYBxC
 knjNIUklFCAo9X5qFPvkbJaKjW0cIhLaVP61rfjh+N0uxK60m3nsvNzAhnvDKaepUfXno4kEt
 5j3DP7wrLOpuTND2e950+r1s5LW9xfXlM95+pJ8R9wDQ7g/guV6V9CEAhe0SGIvoOFQcvNuul
 u/C/QnhDTFHw9q/kwT+3uKRwVgFpXYhW2ydhBYKf4GBWMP0sn9evG08UpIOmWNTRpMEZJ1jef
 GCewDhNlor897HJmW3RAZSfainARF7MlFdJGrzaOsCZXc7l4RPvxHWRMZccJ9QMMmXPHntGZW
 ve05B5ECLlNW2QfKg5CA4kahUcTCGX7U3KpZO06zQyWpQaqLYH+JWIjz4iTiF/7EtXjYZKvOV
 8jTk9GKuwuI7/yPTpxhYlG6+gLM3ofnMZUE79b43VFrw2eswY03zFRoZt4DG+9RzxNfZcr7s3
 Va9o7u6EcPmzvE0NeQ+Y3jUF+3edUAhLEpNNLgDZINbfnBkbh44XnFKo8VORT+EuwHQKX2fXO
 2UvHveYlr5Afq8cqvJl7HTRhS9MRF8o/SSB7R6NwuVb+Xod7uc3h7126FPNh55og6rsN/R6RE
 DphfND7JUhk87TGTKBLHIgKu+6HDcEyiQQpw9t0V7Fprx4wfbgjblCWX9eS6QAW6nbV8IfHzO
 fenchP/znNWJxrWQYp1fUra7OLLlrb1Ykv1njlM84IhDqiL2sYC5UEjIDkbFl9HhmqRDDwRS8
 HPwMSns7jTh8GOfd+Mf8j9BBAJ/tRj/tHOeqJIR+YwiG3aO4AEXxf3QTUWTVacDaLBMic80Jz
 gPGhDxm6Rq9e+F3KZQgFA+76M5TGSKb4Yb5RFawKbsgulFk/c9/y60N1d7iYz8anoVvXnXGUo
 OYyz7vEgczb170gRi4uu7gqSPlOOLfSNRp1Mz2L8C7spTZuZM6UkKtk70KvHurerisSnp+dy/
 TKttWOkh+F3Frg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------aAj0KYSwQwAzBQ1X7M7n9DPy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2021/11/2 04:03, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
>>
>> There's a merge conflict due to the last minute 5.15 changes (kmap
>> reverts) and the conflict is not trivial.
>
> You don't say.
>
> I ended up just re-doing that resolution entirely, and as I did so, I
> think I found a bug in the original revert that caused the conflict in
> the first place.
>
> And since that revert made it into 5.15, I felt like I had to fix that
> bug first - and separately - so that the fix can be backported to
> stable.
>
> I then re-did my merge on top of that hopefully fixed state, and maybe
> it's correct.
>
> Or maybe I messed up entirely.
>
> I did end up comparing it to your other branch too, but that was
> equally as messy, apart from the "ok, I can mindlessly just take your
> side".
>
> And it was fairly different from what I had done in my merge
> resolution, so who knows.
>
> ANYWAY. What I'm trying to say is that you should look very very
> carefully at commits
>
>    2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")

Since I'm doing the revert manually for lzo part, I double checked the cod=
e.

It turns out, your fix is the same as the original version I sent to
David (although not through the mail list).
Full patch attached.

@@ -345,8 +358,9 @@ int lzo_decompress_bio(struct list_head *ws, struct
compressed_bio *cb)
  		       (cur_in + LZO_LEN - 1) / sectorsize);
  		cur_page =3D cb->compressed_pages[cur_in / PAGE_SIZE];
  		ASSERT(cur_page);
-		seg_len =3D read_compress_length(page_address(cur_page) +
-					       offset_in_page(cur_in));
+		kaddr =3D kmap(cur_page);
+		seg_len =3D read_compress_length(kaddr + offset_in_page(cur_in));
+		kunmap(cur_page);
  		cur_in +=3D LZO_LEN;

Thus it looks like by somehow my version is not applied?

Thanks,
Qu

>    037c50bfbeb3 ("Merge tag 'for-5.16-tag' of git://git.../linux") >
> because I marked that first one for stable, and the second is
> obviously my entirely untested merge.
>
> It makes sense to me, but apart from "it builds", I've not actually
> tested any of it. This is all purely from looking at the code and
> trying to figure out what the RightThing(tm) is.
>
> Obviously the kmap thing tends to only be noticeable on 32-bit
> platforms, and that lzo_decompress_bio() bug also needs just the
> proper filesystem settings to trigger in the first place.
>
> Again - please take a careful look. Both at my merge and at that
> alleged kmap fix.
>
>                            Linus
>

--------------aAj0KYSwQwAzBQ1X7M7n9DPy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-btrfs-compression-drop-kmap-kunmap-from-lzo.patch"
Content-Disposition: attachment;
 filename*0="0001-Revert-btrfs-compression-drop-kmap-kunmap-from-lzo.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSAzOGM0ODM5NWMxZjNjYjhhYWVhNDQ5ZGJhYTgxY2YwZWZkYzAxMmQ4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4KRGF0ZTog
V2VkLCAyNyBPY3QgMjAyMSAxNzowNTozNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFJldmVy
dCAiYnRyZnM6IGNvbXByZXNzaW9uOiBkcm9wIGttYXAva3VubWFwIGZyb20gbHpvIgoKVGhp
cyByZXZlcnRzIGNvbW1pdCA4Yzk0NWQzMmU2MDQyN2NiYzA4NTljZjcwNDViYmU2MTk2YmIw
M2Q4LgotLS0KIGZzL2J0cmZzL2x6by5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2x6by5jIGIvZnMvYnRyZnMvbHpv
LmMKaW5kZXggYzI1ZGZkMWE4YTU0Li4yOTViYmMxM2FjZTYgMTAwNjQ0Ci0tLSBhL2ZzL2J0
cmZzL2x6by5jCisrKyBiL2ZzL2J0cmZzL2x6by5jCkBAIC0xNDEsNyArMTQxLDcgQEAgaW50
IGx6b19jb21wcmVzc19wYWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICp3cywgc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcsCiAJKnRvdGFsX2luID0gMDsKIAogCWluX3BhZ2UgPSBmaW5k
X2dldF9wYWdlKG1hcHBpbmcsIHN0YXJ0ID4+IFBBR0VfU0hJRlQpOwotCWRhdGFfaW4gPSBw
YWdlX2FkZHJlc3MoaW5fcGFnZSk7CisJZGF0YV9pbiA9IGttYXAoaW5fcGFnZSk7CiAKIAkv
KgogCSAqIHN0b3JlIHRoZSBzaXplIG9mIGFsbCBjaHVua3Mgb2YgY29tcHJlc3NlZCBkYXRh
IGluCkBAIC0xNTIsNyArMTUyLDcgQEAgaW50IGx6b19jb21wcmVzc19wYWdlcyhzdHJ1Y3Qg
bGlzdF9oZWFkICp3cywgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCXJldCA9
IC1FTk9NRU07CiAJCWdvdG8gb3V0OwogCX0KLQljcGFnZV9vdXQgPSBwYWdlX2FkZHJlc3Mo
b3V0X3BhZ2UpOworCWNwYWdlX291dCA9IGttYXAob3V0X3BhZ2UpOwogCW91dF9vZmZzZXQg
PSBMWk9fTEVOOwogCXRvdF9vdXQgPSBMWk9fTEVOOwogCXBhZ2VzWzBdID0gb3V0X3BhZ2U7
CkBAIC0yMTAsNiArMjEwLDcgQEAgaW50IGx6b19jb21wcmVzc19wYWdlcyhzdHJ1Y3QgbGlz
dF9oZWFkICp3cywgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCQkJaWYgKG91
dF9sZW4gPT0gMCAmJiB0b3RfaW4gPj0gbGVuKQogCQkJCQlicmVhazsKIAorCQkJCWt1bm1h
cChvdXRfcGFnZSk7CiAJCQkJaWYgKG5yX3BhZ2VzID09IG5yX2Rlc3RfcGFnZXMpIHsKIAkJ
CQkJb3V0X3BhZ2UgPSBOVUxMOwogCQkJCQlyZXQgPSAtRTJCSUc7CkBAIC0yMjEsNyArMjIy
LDcgQEAgaW50IGx6b19jb21wcmVzc19wYWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICp3cywgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCQkJCXJldCA9IC1FTk9NRU07CiAJCQkJ
CWdvdG8gb3V0OwogCQkJCX0KLQkJCQljcGFnZV9vdXQgPSBwYWdlX2FkZHJlc3Mob3V0X3Bh
Z2UpOworCQkJCWNwYWdlX291dCA9IGttYXAob3V0X3BhZ2UpOwogCQkJCXBhZ2VzW25yX3Bh
Z2VzKytdID0gb3V0X3BhZ2U7CiAKIAkJCQlwZ19ieXRlc19sZWZ0ID0gUEFHRV9TSVpFOwpA
QCAtMjQzLDExICsyNDQsMTIgQEAgaW50IGx6b19jb21wcmVzc19wYWdlcyhzdHJ1Y3QgbGlz
dF9oZWFkICp3cywgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCQlicmVhazsK
IAogCQlieXRlc19sZWZ0ID0gbGVuIC0gdG90X2luOworCQlrdW5tYXAoaW5fcGFnZSk7CiAJ
CXB1dF9wYWdlKGluX3BhZ2UpOwogCiAJCXN0YXJ0ICs9IFBBR0VfU0laRTsKIAkJaW5fcGFn
ZSA9IGZpbmRfZ2V0X3BhZ2UobWFwcGluZywgc3RhcnQgPj4gUEFHRV9TSElGVCk7Ci0JCWRh
dGFfaW4gPSBwYWdlX2FkZHJlc3MoaW5fcGFnZSk7CisJCWRhdGFfaW4gPSBrbWFwKGluX3Bh
Z2UpOwogCQlpbl9sZW4gPSBtaW4oYnl0ZXNfbGVmdCwgUEFHRV9TSVpFKTsKIAl9CiAKQEAg
LTI1NywxNyArMjU5LDIyIEBAIGludCBsem9fY29tcHJlc3NfcGFnZXMoc3RydWN0IGxpc3Rf
aGVhZCAqd3MsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCX0KIAogCS8qIHN0
b3JlIHRoZSBzaXplIG9mIGFsbCBjaHVua3Mgb2YgY29tcHJlc3NlZCBkYXRhICovCi0Jc2l6
ZXNfcHRyID0gcGFnZV9hZGRyZXNzKHBhZ2VzWzBdKTsKKwlzaXplc19wdHIgPSBrbWFwX2xv
Y2FsX3BhZ2UocGFnZXNbMF0pOwogCXdyaXRlX2NvbXByZXNzX2xlbmd0aChzaXplc19wdHIs
IHRvdF9vdXQpOworCWt1bm1hcF9sb2NhbChzaXplc19wdHIpOwogCiAJcmV0ID0gMDsKIAkq
dG90YWxfb3V0ID0gdG90X291dDsKIAkqdG90YWxfaW4gPSB0b3RfaW47CiBvdXQ6CiAJKm91
dF9wYWdlcyA9IG5yX3BhZ2VzOworCWlmIChvdXRfcGFnZSkKKwkJa3VubWFwKG91dF9wYWdl
KTsKIAotCWlmIChpbl9wYWdlKQorCWlmIChpbl9wYWdlKSB7CisJCWt1bm1hcChpbl9wYWdl
KTsKIAkJcHV0X3BhZ2UoaW5fcGFnZSk7CisJfQogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTI4
Myw2ICsyOTAsNyBAQCBzdGF0aWMgdm9pZCBjb3B5X2NvbXByZXNzZWRfc2VnbWVudChzdHJ1
Y3QgY29tcHJlc3NlZF9iaW8gKmNiLAogCXUzMiBvcmlnX2luID0gKmN1cl9pbjsKIAogCXdo
aWxlICgqY3VyX2luIDwgb3JpZ19pbiArIGxlbikgeworCQljaGFyICprYWRkcjsKIAkJc3Ry
dWN0IHBhZ2UgKmN1cl9wYWdlOwogCQl1MzIgY29weV9sZW4gPSBtaW5fdCh1MzIsIFBBR0Vf
U0laRSAtIG9mZnNldF9pbl9wYWdlKCpjdXJfaW4pLAogCQkJCQkgIG9yaWdfaW4gKyBsZW4g
LSAqY3VyX2luKTsKQEAgLTI5MCw5ICsyOTgsMTEgQEAgc3RhdGljIHZvaWQgY29weV9jb21w
cmVzc2VkX3NlZ21lbnQoc3RydWN0IGNvbXByZXNzZWRfYmlvICpjYiwKIAkJQVNTRVJUKGNv
cHlfbGVuKTsKIAkJY3VyX3BhZ2UgPSBjYi0+Y29tcHJlc3NlZF9wYWdlc1sqY3VyX2luIC8g
UEFHRV9TSVpFXTsKIAorCQlrYWRkciA9IGttYXAoY3VyX3BhZ2UpOwogCQltZW1jcHkoZGVz
dCArICpjdXJfaW4gLSBvcmlnX2luLAotCQkJcGFnZV9hZGRyZXNzKGN1cl9wYWdlKSArIG9m
ZnNldF9pbl9wYWdlKCpjdXJfaW4pLAorCQkJa2FkZHIgKyBvZmZzZXRfaW5fcGFnZSgqY3Vy
X2luKSwKIAkJCWNvcHlfbGVuKTsKKwkJa3VubWFwKGN1cl9wYWdlKTsKIAogCQkqY3VyX2lu
ICs9IGNvcHlfbGVuOwogCX0KQEAgLTMwMyw2ICszMTMsNyBAQCBpbnQgbHpvX2RlY29tcHJl
c3NfYmlvKHN0cnVjdCBsaXN0X2hlYWQgKndzLCBzdHJ1Y3QgY29tcHJlc3NlZF9iaW8gKmNi
KQogCXN0cnVjdCB3b3Jrc3BhY2UgKndvcmtzcGFjZSA9IGxpc3RfZW50cnkod3MsIHN0cnVj
dCB3b3Jrc3BhY2UsIGxpc3QpOwogCWNvbnN0IHN0cnVjdCBidHJmc19mc19pbmZvICpmc19p
bmZvID0gYnRyZnNfc2IoY2ItPmlub2RlLT5pX3NiKTsKIAljb25zdCB1MzIgc2VjdG9yc2l6
ZSA9IGZzX2luZm8tPnNlY3RvcnNpemU7CisJY2hhciAqa2FkZHI7CiAJaW50IHJldDsKIAkv
KiBDb21wcmVzc2VkIGRhdGEgbGVuZ3RoLCBjYW4gYmUgdW5hbGlnbmVkICovCiAJdTMyIGxl
bl9pbjsKQEAgLTMxMSw3ICszMjIsOSBAQCBpbnQgbHpvX2RlY29tcHJlc3NfYmlvKHN0cnVj
dCBsaXN0X2hlYWQgKndzLCBzdHJ1Y3QgY29tcHJlc3NlZF9iaW8gKmNiKQogCS8qIEJ5dGVz
IGRlY29tcHJlc3NlZCBzbyBmYXIgKi8KIAl1MzIgY3VyX291dCA9IDA7CiAKLQlsZW5faW4g
PSByZWFkX2NvbXByZXNzX2xlbmd0aChwYWdlX2FkZHJlc3MoY2ItPmNvbXByZXNzZWRfcGFn
ZXNbMF0pKTsKKwlrYWRkciA9IGttYXAoY2ItPmNvbXByZXNzZWRfcGFnZXNbMF0pOworCWxl
bl9pbiA9IHJlYWRfY29tcHJlc3NfbGVuZ3RoKGthZGRyKTsKKwlrdW5tYXAoY2ItPmNvbXBy
ZXNzZWRfcGFnZXNbMF0pOwogCWN1cl9pbiArPSBMWk9fTEVOOwogCiAJLyoKQEAgLTM0NSw4
ICszNTgsOSBAQCBpbnQgbHpvX2RlY29tcHJlc3NfYmlvKHN0cnVjdCBsaXN0X2hlYWQgKndz
LCBzdHJ1Y3QgY29tcHJlc3NlZF9iaW8gKmNiKQogCQkgICAgICAgKGN1cl9pbiArIExaT19M
RU4gLSAxKSAvIHNlY3RvcnNpemUpOwogCQljdXJfcGFnZSA9IGNiLT5jb21wcmVzc2VkX3Bh
Z2VzW2N1cl9pbiAvIFBBR0VfU0laRV07CiAJCUFTU0VSVChjdXJfcGFnZSk7Ci0JCXNlZ19s
ZW4gPSByZWFkX2NvbXByZXNzX2xlbmd0aChwYWdlX2FkZHJlc3MoY3VyX3BhZ2UpICsKLQkJ
CQkJICAgICAgIG9mZnNldF9pbl9wYWdlKGN1cl9pbikpOworCQlrYWRkciA9IGttYXAoY3Vy
X3BhZ2UpOworCQlzZWdfbGVuID0gcmVhZF9jb21wcmVzc19sZW5ndGgoa2FkZHIgKyBvZmZz
ZXRfaW5fcGFnZShjdXJfaW4pKTsKKwkJa3VubWFwKGN1cl9wYWdlKTsKIAkJY3VyX2luICs9
IExaT19MRU47CiAKIAkJLyogQ29weSB0aGUgY29tcHJlc3NlZCBzZWdtZW50IHBheWxvYWQg
aW50byB3b3Jrc3BhY2UgKi8KQEAgLTQzMSw3ICs0NDUsNyBAQCBpbnQgbHpvX2RlY29tcHJl
c3Moc3RydWN0IGxpc3RfaGVhZCAqd3MsIHVuc2lnbmVkIGNoYXIgKmRhdGFfaW4sCiAJZGVz
dGxlbiA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIGRlc3RsZW4sIFBBR0VfU0laRSk7CiAJYnl0
ZXMgPSBtaW5fdCh1bnNpZ25lZCBsb25nLCBkZXN0bGVuLCBvdXRfbGVuIC0gc3RhcnRfYnl0
ZSk7CiAKLQlrYWRkciA9IHBhZ2VfYWRkcmVzcyhkZXN0X3BhZ2UpOworCWthZGRyID0ga21h
cF9sb2NhbF9wYWdlKGRlc3RfcGFnZSk7CiAJbWVtY3B5KGthZGRyLCB3b3Jrc3BhY2UtPmJ1
ZiArIHN0YXJ0X2J5dGUsIGJ5dGVzKTsKIAogCS8qCkBAIC00NDEsNiArNDU1LDcgQEAgaW50
IGx6b19kZWNvbXByZXNzKHN0cnVjdCBsaXN0X2hlYWQgKndzLCB1bnNpZ25lZCBjaGFyICpk
YXRhX2luLAogCSAqLwogCWlmIChieXRlcyA8IGRlc3RsZW4pCiAJCW1lbXNldChrYWRkciti
eXRlcywgMCwgZGVzdGxlbi1ieXRlcyk7CisJa3VubWFwX2xvY2FsKGthZGRyKTsKIG91dDoK
IAlyZXR1cm4gcmV0OwogfQotLSAKMi4zMy4xCgo=
--------------aAj0KYSwQwAzBQ1X7M7n9DPy--

