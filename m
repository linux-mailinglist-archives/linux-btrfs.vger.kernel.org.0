Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46393FBA3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbhH3QkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH3QkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 12:40:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6538C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 09:39:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w17so2484025qta.9
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 09:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=wy2zijq7tIYiyV0Wg9xhCRZd0eJH9DThx8S6A0NKAVc=;
        b=aHRfX0CApx8CsPzOlZgOMcNw7JcxwKJnxxnTEZ+CaCage+luwpFgZw+Ohvuovl4/Lr
         ZuYNenSIP3AT2W9Hc5Wh7BWH72tMbWVguERkirYYRI25SqOlUoRdtVIZzLSu/k+PKaAX
         zguOIa4WH16O8uGBJcYgMXKHgdjFr3hY2K7lRq6kTWsy6fEF379EPgHJESco8tJikOYP
         PeJU7HuRZ76reC26YJjn4HCOdOtPtabewEf92I0ajks9crBu0e+g26ieEvF4s4JU8qHt
         8b8I70DXtOsCnigsLFjS+QaqqmZwqjJWhjfyfs9+fOiAQN0f87kG+XCuU36dXu9iI1Dw
         UXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wy2zijq7tIYiyV0Wg9xhCRZd0eJH9DThx8S6A0NKAVc=;
        b=EJYhTlf7TEmf9n8HJfBooY/sqc4pplYDD6NogjI+evgsBt8y/3KsKTnMxgvY63mFlw
         MBr7kkYhIlmTxmAi1fN0Eg6qO6/A9Pnx4Y6RXGTN/a0N4EsbNX1baWG1IGUjeYPkfCWk
         YEZSe2hF7K3yRWj7ONWk+IRHJXVWDbPwMIALihdBrmUjxHA56w0nSppoe5Lefp8B2Uak
         q2B2QhnvFkuvch+JNsEOoTsL1IiMpvQhS02BYD1JTruILVOpCORq0SOJk8Mo2FXWT0tA
         FqE+oBWSRxvJO9IoyEu+W/H93fF9tIv/1VJaRNmGAROrxlJ0f+XTG+HwMIb7LCvvtpef
         I0XQ==
X-Gm-Message-State: AOAM530XuAohrdpGua9Bkl4RT/r5InlTJhA62hT+o2QyV68sgVj5bQlI
        lGNXvYZ70VOm8c3yVFf7oKyk9ZQuab+Q04EvbTFQlwkwMkA=
X-Google-Smtp-Source: ABdhPJwSz2yJtcUPnzv4/uMN4q9Qt5Q1WDru+rc71mFgGTPvzPD8zkEVW3nv1zKFm3JYr/H5Wf/P1SntrbpElJ0mcVo=
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr21559800qtx.213.1630341564105;
 Mon, 30 Aug 2021 09:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com>
 <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com> <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
In-Reply-To: <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 17:38:47 +0100
Message-ID: <CAL3q7H46BpkE+aa00Y71SfTizpOo+4ADhBHU2vme4t-aYO6Zuw@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cabe6205cac979b6"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000cabe6205cac979b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2021 at 11:51 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, Aug 27, 2021 at 10:05 PM Darrell Enns <darrell@darrellenns.com> w=
rote:
> >
> > Inode number of places.sqlite is 400698. It's the same in both
> > snapshots, as well as the current active subvolume.
> >
> > From 2nd snapshot (id 977):
> >   Size: 83886080      Blocks: 163840     IO Block: 4096   regular file
> > Device: 5fh/95d    Inode: 400698      Links: 1
> > Access: (0640/-rw-r-----)  Uid: ( 1000/   denns)   Gid: ( 1000/   denns=
)
> > Access: 2021-08-27 09:59:01.619570401 -0700
> > Modify: 2021-08-27 10:06:43.952629419 -0700
> > Change: 2021-08-27 10:06:43.952629419 -0700
> >  Birth: 2021-08-07 20:16:37.080012116 -0700
>
> Thanks.
> A quick first look shows me that the cause is not what I initially
> suspected - the clone operation that fails is not from the inode at
> the send snapshot to the same inode at the send snapshot (cloning from
> itself), but instead from the parent snapshot to the send snapshot.
> The clone offset and length seem valid at first glance, as clone range
> is within the eof of the inode in the parent snapshot and it's
> properly aligned. So I'll have to recreate the same extent layout and
> see if it fails, which will take a while.
>
> Can you please keep those snapshots (IDs 977 and 881) for a few days,
> in case of the need to get more debug information or to try a patch?
>
> Also, I forgot to ask before, but you are not passing any clone roots
> to "btrfs send" (-c command line argument), right?
>
> Thanks, I'll get back to you later.

Ok, so I tried a test using the same file extent layout that you have
for the parent and send snapshots, but it didn't fail:

(...)
write foobar - offset=3D79036416 length=3D32768
write foobar - offset=3D79069184 length=3D32768
write foobar - offset=3D79101952 length=3D32768
clone foobar - source=3Dfoobar source offset=3D79134720 offset=3D79134720
length=3D4751360
utimes foobar
(...)

Apart from the file name (which is irrelevant), the offsets, lengths
and operations match the ones you pasted before.
So this is really weird, and it's a different case from the last fixes
you found, since in this case the clone operation is from the parent
to the send snapshot, and not from the send snapshot to the send
snapshot (and same inode) - which should work just fine since the
range is within the EOF limit of the file and it's properly aligned.

If you still have those snapshots, with IDs of 881 (parent) and 977
(send), can you apply the attached debug patch, run the incremental
send with those two snapshots and paste the messages from
dmesg/syslog?

I also pasted the debug patch at:  https://pastebin.com/raw/RnZRDhD0

Thanks, that would help a lot.

>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

--000000000000cabe6205cac979b6
Content-Type: text/x-patch; charset="US-ASCII"; name="debug_send_clone.patch"
Content-Disposition: attachment; filename="debug_send_clone.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ksyv1ttt0>
X-Attachment-Id: f_ksyv1ttt0

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3JlZmxpbmsuYyBiL2ZzL2J0cmZzL3JlZmxpbmsuYwppbmRl
eCA0YTVmMmMzNWMwMzQuLmE0YTAwZGI5ZDU0NyAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvcmVmbGlu
ay5jCisrKyBiL2ZzL2J0cmZzL3JlZmxpbmsuYwpAQCAtNzgwLDYgKzc4MCwxMyBAQCBzdGF0aWMg
aW50IGJ0cmZzX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcChzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9m
Zl90IHBvc19pbiwKIAkvKiBEb24ndCBtYWtlIHRoZSBkc3QgZmlsZSBwYXJ0bHkgY2hlY2tzdW1t
ZWQgKi8KIAlpZiAoKEJUUkZTX0koaW5vZGVfaW4pLT5mbGFncyAmIEJUUkZTX0lOT0RFX05PREFU
QVNVTSkgIT0KIAkgICAgKEJUUkZTX0koaW5vZGVfb3V0KS0+ZmxhZ3MgJiBCVFJGU19JTk9ERV9O
T0RBVEFTVU0pKSB7CisJCWlmICghKHJlbWFwX2ZsYWdzICYgUkVNQVBfRklMRV9ERURVUCkpIHsK
KwkJCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gQlRSRlNfSShpbm9kZV9pbiktPnJv
b3QtPmZzX2luZm87CisKKwkJCWJ0cmZzX2luZm8oZnNfaW5mbywgImNsb25lOiBub2RhdGFzdW0g
bWlzbWF0Y2gsIHNyYyAlbGx1IChyb290ICVsbHUpIGRzdCAlbGx1IChyb290ICVsbHUpIiwKKwkJ
CQkgICBidHJmc19pbm8oQlRSRlNfSShpbm9kZV9pbikpLCBCVFJGU19JKGlub2RlX2luKS0+cm9v
dC0+cm9vdF9rZXkub2JqZWN0aWQsCisJCQkJICAgYnRyZnNfaW5vKEJUUkZTX0koaW5vZGVfb3V0
KSksIEJUUkZTX0koaW5vZGVfb3V0KS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQpOworCQl9CiAJ
CXJldHVybiAtRUlOVkFMOwogCX0KIApAQCAtODYzLDkgKzg3MCwxNiBAQCBsb2ZmX3QgYnRyZnNf
cmVtYXBfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqc3JjX2ZpbGUsIGxvZmZfdCBvZmYsCiAJc3Ry
dWN0IGlub2RlICpkc3RfaW5vZGUgPSBmaWxlX2lub2RlKGRzdF9maWxlKTsKIAlib29sIHNhbWVf
aW5vZGUgPSBkc3RfaW5vZGUgPT0gc3JjX2lub2RlOwogCWludCByZXQ7Ci0KLQlpZiAocmVtYXBf
ZmxhZ3MgJiB+KFJFTUFQX0ZJTEVfREVEVVAgfCBSRU1BUF9GSUxFX0FEVklTT1JZKSkKKwlzdHJ1
Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IEJUUkZTX0koc3JjX2lub2RlKS0+cm9vdC0+ZnNf
aW5mbzsKKwljb25zdCBsb2ZmX3Qgb2xlbiA9IGxlbjsKKworCWlmIChyZW1hcF9mbGFncyAmIH4o
UkVNQVBfRklMRV9ERURVUCB8IFJFTUFQX0ZJTEVfQURWSVNPUlkpKSB7CisJCWJ0cmZzX2luZm8o
ZnNfaW5mbywgImNsb25lOiAtRUlOVkFMIGZsYWdzLCBzcmMgJWxsdSAocm9vdCAlbGx1KSBkc3Qg
JWxsdSAocm9vdCAlbGx1KSwgb2ZmICVsbGQgZGVzdG9mZiAlbGxkIGxlbiAlbGxkIG9sZW4gJWxs
ZCwgc3JjIGlfc2l6ZSAlbGxkIGRzdCBpX3NpemUgJWxsZCBicyAlbHUgcmVtYXBfZmxhZ3MgJXUi
LAorCQkJICAgYnRyZnNfaW5vKEJUUkZTX0koc3JjX2lub2RlKSksIEJUUkZTX0koc3JjX2lub2Rl
KS0+cm9vdC0+cm9vdF9rZXkub2JqZWN0aWQsCisJCQkgICBidHJmc19pbm8oQlRSRlNfSShkc3Rf
aW5vZGUpKSwgQlRSRlNfSShkc3RfaW5vZGUpLT5yb290LT5yb290X2tleS5vYmplY3RpZCwKKwkJ
CSAgIG9mZiwgZGVzdG9mZiwgbGVuLCBvbGVuLCBpX3NpemVfcmVhZChzcmNfaW5vZGUpLCBpX3Np
emVfcmVhZChkc3RfaW5vZGUpLCBkc3RfaW5vZGUtPmlfc2ItPnNfYmxvY2tzaXplLCByZW1hcF9m
bGFncyk7CiAJCXJldHVybiAtRUlOVkFMOworCX0KIAogCWlmIChzYW1lX2lub2RlKSB7CiAJCWJ0
cmZzX2lub2RlX2xvY2soc3JjX2lub2RlLCBCVFJGU19JTE9DS19NTUFQKTsKQEAgLTg3Niw2ICs4
OTAsMTEgQEAgbG9mZl90IGJ0cmZzX3JlbWFwX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUgKnNyY19m
aWxlLCBsb2ZmX3Qgb2ZmLAogCiAJcmV0ID0gYnRyZnNfcmVtYXBfZmlsZV9yYW5nZV9wcmVwKHNy
Y19maWxlLCBvZmYsIGRzdF9maWxlLCBkZXN0b2ZmLAogCQkJCQkgICZsZW4sIHJlbWFwX2ZsYWdz
KTsKKwlpZiAocmV0ID09IC1FSU5WQUwgJiYgIShyZW1hcF9mbGFncyAmIFJFTUFQX0ZJTEVfREVE
VVApKQorCQlidHJmc19pbmZvKGZzX2luZm8sICJjbG9uZTogLUVJTlZBTCBvdGhlciwgc3JjICVs
bHUgKHJvb3QgJWxsdSkgZHN0ICVsbHUgKHJvb3QgJWxsdSksIG9mZiAlbGxkIGRlc3RvZmYgJWxs
ZCBsZW4gJWxsZCBvbGVuICVsbGQsIHNyYyBpX3NpemUgJWxsZCBkc3QgaV9zaXplICVsbGQgYnMg
JWx1IHJlbWFwX2ZsYWdzICV1IiwKKwkJCSAgIGJ0cmZzX2lubyhCVFJGU19JKHNyY19pbm9kZSkp
LCBCVFJGU19JKHNyY19pbm9kZSktPnJvb3QtPnJvb3Rfa2V5Lm9iamVjdGlkLAorCQkJICAgYnRy
ZnNfaW5vKEJUUkZTX0koZHN0X2lub2RlKSksIEJUUkZTX0koZHN0X2lub2RlKS0+cm9vdC0+cm9v
dF9rZXkub2JqZWN0aWQsCisJCQkgICBvZmYsIGRlc3RvZmYsIGxlbiwgb2xlbiwgaV9zaXplX3Jl
YWQoc3JjX2lub2RlKSwgaV9zaXplX3JlYWQoZHN0X2lub2RlKSwgZHN0X2lub2RlLT5pX3NiLT5z
X2Jsb2Nrc2l6ZSwgcmVtYXBfZmxhZ3MpOwogCWlmIChyZXQgPCAwIHx8IGxlbiA9PSAwKQogCQln
b3RvIG91dF91bmxvY2s7CiAKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NlbmQuYyBiL2ZzL2J0cmZz
L3NlbmQuYwppbmRleCBhZmRjYmU3ODQ0ZTAuLmFkODI5YzAwYzNjZSAxMDA2NDQKLS0tIGEvZnMv
YnRyZnMvc2VuZC5jCisrKyBiL2ZzL2J0cmZzL3NlbmQuYwpAQCAtNTI4MCw2ICs1MjgwLDEwIEBA
IHN0YXRpYyBpbnQgY2xvbmVfcmFuZ2Uoc3RydWN0IHNlbmRfY3R4ICpzY3R4LAogCXN0cnVjdCBi
dHJmc19rZXkga2V5OwogCWludCByZXQ7CiAJdTY0IGNsb25lX3NyY19pX3NpemUgPSAwOworCXN0
cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gc2N0eC0+c2VuZF9yb290LT5mc19pbmZvOwor
CWNvbnN0IGJvb2wgZGVidWcgPSAoc2N0eC0+Y3VyX2lubyA9PSA0MDA2OTggJiYKKwkJCSAgICBj
bG9uZV9yb290LT5pbm8gPT0gNDAwNjk4ICYmCisJCQkgICAgc2N0eC0+c2VuZF9yb290LT5yb290
X2tleS5vYmplY3RpZCA9PSA5OTcpOwogCiAJLyoKIAkgKiBQcmV2ZW50IGNsb25pbmcgZnJvbSBh
IHplcm8gb2Zmc2V0IHdpdGggYSBsZW5ndGggbWF0Y2hpbmcgdGhlIHNlY3RvcgpAQCAtNTM0OSw2
ICs1MzUzLDEwIEBAIHN0YXRpYyBpbnQgY2xvbmVfcmFuZ2Uoc3RydWN0IHNlbmRfY3R4ICpzY3R4
LAogCQkJcGF0aC0+c2xvdHNbMF0tLTsKIAl9CiAKKwlpZiAoZGVidWcpCisJCWJ0cmZzX2luZm8o
ZnNfaW5mbywgInNlbmQ6IGNsb25lX3JhbmdlKCkgc3RhcnQsIHJvb3QgJWxsdSBvZmZzZXQgJWxs
dSBkYXRhX29mZnNldCAlbGx1IGxlbiAlbGx1IGRpc2tfYnl0ZSAlbGx1IGNsb25lX3NyY19pX3Np
emUgJWxsdSIsCisJCQkgICBjbG9uZV9yb290LT5yb290LT5yb290X2tleS5vYmplY3RpZCwgY2xv
bmVfcm9vdC0+b2Zmc2V0LCBkYXRhX29mZnNldCwgbGVuLCBkaXNrX2J5dGUsIGNsb25lX3NyY19p
X3NpemUpOworCiAJd2hpbGUgKHRydWUpIHsKIAkJc3RydWN0IGV4dGVudF9idWZmZXIgKmxlYWYg
PSBwYXRoLT5ub2Rlc1swXTsKIAkJaW50IHNsb3QgPSBwYXRoLT5zbG90c1swXTsKQEAgLTU0MTcs
NiArNTQyNSwxMSBAQCBzdGF0aWMgaW50IGNsb25lX3JhbmdlKHN0cnVjdCBzZW5kX2N0eCAqc2N0
eCwKIAkJCWV4dF9sZW4gPSBjbG9uZV9zcmNfaV9zaXplIC0ga2V5Lm9mZnNldDsKIAogCQljbG9u
ZV9kYXRhX29mZnNldCA9IGJ0cmZzX2ZpbGVfZXh0ZW50X29mZnNldChsZWFmLCBlaSk7CisKKwkJ
aWYgKGRlYnVnKQorCQkJYnRyZnNfaW5mbyhmc19pbmZvLCAic2VuZDogY2xvbmVfcmFuZ2UoKSBz
dGVwIDEsIHJvb3Qgb2Zmc2V0ICVsbHUgZGF0YV9vZmZzZXQgJWxsdSBsZW4gJWxsdSBvZmZzZXQg
JWxsdSwga2V5Lm9mZnNldCAlbGx1IGV4dF9sZW4gJWxsdSBjbG9uZV9kYXRhX29mZnNldCAlbGx1
IGZvdW5kIGRpc2tfYnl0ZSAlbGx1IiwKKwkJCQkgICBjbG9uZV9yb290LT5vZmZzZXQsIGRhdGFf
b2Zmc2V0LCBsZW4sIG9mZnNldCwga2V5Lm9mZnNldCwgZXh0X2xlbiwgY2xvbmVfZGF0YV9vZmZz
ZXQsIGJ0cmZzX2ZpbGVfZXh0ZW50X2Rpc2tfYnl0ZW5yKGxlYWYsIGVpKSk7CisKIAkJaWYgKGJ0
cmZzX2ZpbGVfZXh0ZW50X2Rpc2tfYnl0ZW5yKGxlYWYsIGVpKSA9PSBkaXNrX2J5dGUpIHsKIAkJ
CWNsb25lX3Jvb3QtPm9mZnNldCA9IGtleS5vZmZzZXQ7CiAJCQlpZiAoY2xvbmVfZGF0YV9vZmZz
ZXQgPCBkYXRhX29mZnNldCAmJgpAQCAtNTQ2Miw2ICs1NDc1LDEwIEBAIHN0YXRpYyBpbnQgY2xv
bmVfcmFuZ2Uoc3RydWN0IHNlbmRfY3R4ICpzY3R4LAogCiAJCQkJc2xlbiA9IEFMSUdOX0RPV04o
c3JjX2VuZCAtIGNsb25lX3Jvb3QtPm9mZnNldCwKIAkJCQkJCSAgc2VjdG9yc2l6ZSk7CisJCQkJ
aWYgKGRlYnVnKQorCQkJCQlidHJmc19pbmZvKGZzX2luZm8sICJzZW5kOiBjbG9uZV9yYW5nZSgp
IHN0ZXAgMi0xLCByb290IG9mZnNldCAlbGx1IGRhdGFfb2Zmc2V0ICVsbHUgbGVuICVsbHUgb2Zm
c2V0ICVsbHUsIGNsb25lX2xlbiAlbGx1IHNyY19lbmQgJWxsdSBzbGVuICVsbHUiLAorCQkJCQkJ
ICAgY2xvbmVfcm9vdC0+b2Zmc2V0LCBkYXRhX29mZnNldCwgbGVuLCBvZmZzZXQsIGNsb25lX2xl
biwgc3JjX2VuZCwgc2xlbik7CisKIAkJCQlpZiAoc2xlbiA+IDApIHsKIAkJCQkJcmV0ID0gc2Vu
ZF9jbG9uZShzY3R4LCBvZmZzZXQsIHNsZW4sCiAJCQkJCQkJIGNsb25lX3Jvb3QpOwpAQCAtNTQ3
NSw2ICs1NDkyLDkgQEAgc3RhdGljIGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNj
dHgsCiAJCQkJCQkgY2xvbmVfcm9vdCk7CiAJCQl9CiAJCX0gZWxzZSB7CisJCQlpZiAoZGVidWcp
CisJCQkJYnRyZnNfaW5mbyhmc19pbmZvLCAic2VuZDogY2xvbmVfcmFuZ2UoKSBzdGVwIDItMSwg
cm9vdCBvZmZzZXQgJWxsdSBkYXRhX29mZnNldCAlbGx1IGxlbiAlbGx1IG9mZnNldCAlbGx1IGNs
b25lX2xlbiAlbGx1IiwKKwkJCQkJICAgY2xvbmVfcm9vdC0+b2Zmc2V0LCBkYXRhX29mZnNldCwg
bGVuLCBvZmZzZXQsIGNsb25lX2xlbik7CiAJCQlyZXQgPSBzZW5kX2V4dGVudF9kYXRhKHNjdHgs
IG9mZnNldCwgY2xvbmVfbGVuKTsKIAkJfQogCkBAIC01NTExLDYgKzU1MzEsMTAgQEAgc3RhdGlj
IGludCBjbG9uZV9yYW5nZShzdHJ1Y3Qgc2VuZF9jdHggKnNjdHgsCiAJZWxzZQogCQlyZXQgPSAw
Owogb3V0OgorCWlmIChkZWJ1ZykKKwkJYnRyZnNfaW5mbyhmc19pbmZvLCAic2VuZDogY2xvbmVf
cmFuZ2UoKSBlbmQsIHJvb3QgJWxsdSBvZmZzZXQgJWxsdSBkYXRhX29mZnNldCAlbGx1IGxlbiAl
bGx1IHJldCAlZCIsCisJCQkgICBjbG9uZV9yb290LT5yb290LT5yb290X2tleS5vYmplY3RpZCwg
Y2xvbmVfcm9vdC0+b2Zmc2V0LCBkYXRhX29mZnNldCwgbGVuLCByZXQpOworCiAJYnRyZnNfZnJl
ZV9wYXRoKHBhdGgpOwogCXJldHVybiByZXQ7CiB9Cg==
--000000000000cabe6205cac979b6--
