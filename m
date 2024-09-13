Return-Path: <linux-btrfs+bounces-7989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7669778D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 08:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B699E2818D9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85F187FF7;
	Fri, 13 Sep 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2V+RNnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2901A0BF6
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209006; cv=none; b=TUjRDuQkypO0m2qTvvfu6ZYSr76zEhnp90hMkWH6mNz2ML5xoN5HUalRPU5dgSdlRvcR5Qt1d88iOfF6OMEiV15c6iQAmN+Q3qgnKZmhsHPOjpegIpNTYftt7T9D+tmqz80oZo8ZLla3TejTFTAsBm5coaB+v2XNgdBVshm7NRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209006; c=relaxed/simple;
	bh=U/FeuP7E4B7luuDwdX6H+Qs++vyBwGHfFl5+DSHbJiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Cyc96qevNzXUqJ+TdSns1h97YVmUaOKYEE9IJuYcSsLczcD0WAdxU5CiWTdZXG0lXtBsgR0+uwcFpioH5zUZJJWS/Pio/NaoBpIQOW5oyWyD+24Uy1JSH83eBEf2tnc/ggpq/QIDq15bUZPvEJZnwHhgLJEG+/I5IggW0et6aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2V+RNnn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c3f1939d12so13697877b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 23:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726209004; x=1726813804; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/FeuP7E4B7luuDwdX6H+Qs++vyBwGHfFl5+DSHbJiI=;
        b=W2V+RNnno5I1VINowMhJCO2iFTH13+QRZiAGBpGcYbxNTa4vRYIo0algyrN/nkNexZ
         ykIH85UwFehuosmcsQMi73Y+6SJNApTnI1LnOQK/TlJ9Pi6zTDBeRI1GYqX2mfrR8qSn
         eeyxu/fvuZ5vQP9lpM/EnyeOKHAMT9fi48STysKJtks6ObJg9akqNFJ85ttO9rQzAlwC
         SZTty/8md7x5cnUEtPoboTn1ooyGC2nJECWWIgCyuEy0vjZIsMrFahjKwc2/kxrFwcKg
         8Rmrt6zLafNjYm8bR1V1ppTTqYsW1MH6rBdLDOiWSbaQd2nK2RVGCwa1/cvM+kVnlPst
         6JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726209004; x=1726813804;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/FeuP7E4B7luuDwdX6H+Qs++vyBwGHfFl5+DSHbJiI=;
        b=j/NXUFfVZCunQyg0UJWtdMjPRCL/7IfhDtpOh0RyZJuqBnRg9J9v8MnLRUu1oeod78
         qrqdukL2rGkW+pfqIWX8QV1eY+OEHdN2bmQwKhuCoSd7Lqse6p8hAZgJYWN5HZlTRd8X
         m+b787s/A473Ki8GdzUxtSEB3FWaa8bJQVj5wXWmaa5aEM7PK8e1J/7JvV8NRXVxSyLU
         z9AQTL10z0Dh8TPbyYlwhtbMX7XLV1rcbwx+UHgPdjVSAuSzsA03+s4bCUInDj6L4Amx
         8lw82gje80Y/0rlH1vZcW1oR0XKelyA5/Y/VEjAt1k0CP+jNRyiZq2/zY8jC/A+x5QXQ
         iC5w==
X-Gm-Message-State: AOJu0YwPXSbJlOrZv74+1b4YVX2w0Hl28lsVDtWSdTdX9Nwyn293RDtu
	xMtyaGk4msbWLKTFGMkuQHBkxpx4NzrmIDVFcMD3DI73boJc9mGy0dPb7rt7mLO9Ixg6+PT/hTe
	q2244QjzuCOJfYovbBCTTTza8IdYYUpE=
X-Google-Smtp-Source: AGHT+IH6CiJMQSPKyXZ2INtpH6d6aaR1J/+i46DV3rBdrQrxYBNzTmSq7bV/aJ8cWyQ084wbhR/2Oh1EbcqoWGmSldU=
X-Received: by 2002:a05:690c:ecd:b0:63b:d711:e722 with SMTP id
 00721157ae682-6dbb6ad68b1mr59647167b3.1.1726209004088; Thu, 12 Sep 2024
 23:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABk=v_CWGXrH+wzKFLzOSMuAZXyiJNbzKQqox_qm4e1PhfhBQg@mail.gmail.com>
 <CABk=v_Bpc9nAkLoaNAW7ZEO=e9i3JsYqQgVqht0xZwBPx1n27w@mail.gmail.com>
In-Reply-To: <CABk=v_Bpc9nAkLoaNAW7ZEO=e9i3JsYqQgVqht0xZwBPx1n27w@mail.gmail.com>
From: fcon <aperture.server.owner@gmail.com>
Date: Fri, 13 Sep 2024 06:29:53 +0000
Message-ID: <CABk=v_Bym4weZy-7JcEBgU15ih9kfAjUODjtfH9_k0c=2=_bFw@mail.gmail.com>
Subject: Re: Huge mistake.
To: linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007f7c5b0621fa5a08"

--0000000000007f7c5b0621fa5a08
Content-Type: text/plain; charset="UTF-8"

I've came across
https://lore.kernel.org/linux-btrfs/20220204171551.25122-1-dsterba@suse.com/
and noticed the update "btrfs-progs: check: handle csum generation
properly for --init-csum-tree --init-extent-tree"

I've cancelled for now. I've already ran the csum-tree command before
this, as terrible as an idea as that might sound, and I'm unsure if
it's worth upgrading to a newer release of Mint for tackling this
issue.
I'm sorry for replying so many times in a short span, I'm just
extremely concerned about this drive. I know --repair was a stupid
idea, but it worked out well for me in the past (used KDE partition
manager and it forces this when resizing).

Please let me know if I should resume this process or upgrade first,
or anything else I should do instead. Again, I'll provide any
necessary outputs.
Attached is the output of dmesg when mounting.

On Fri, 13 Sept 2024 at 06:01, fcon <aperture.server.owner@gmail.com> wrote:
>
> I just realized I was on Linux Mint 21.1 (kernel 5.15) on the LiveUSB
> I was modifying the filesystem with. That's probably a big issue here,
> I imagine. Last interacted with the filesystem on 6.10 before all
> this.
>
> On Fri, 13 Sept 2024 at 05:48, fcon <aperture.server.owner@gmail.com> wrote:
> >
> > I've been trying to shrink my BTRFS partition with GParted and that
> > led to me running btrfs check --repair a few times because it
> > complained about errors, it worked the first few times but it's gone
> > awful. The check passed but I kept getting I/O errors upon shrinking,
> > one thing led to another and now I'm running --init-extent-tree on a
> > 2.76TiB partition, and immensely regretting my life choices. From what
> > I can tell, this is going to take a full month.
> >
> > I should've just gone here from the start, but all this was giving me
> > a headache, and at that point it had already taken me days to try and
> > get things sorted.
> >
> > Is there any hope for my files or am I, to put it simply, fucked?
> >
> > I'll provide anything that's needed. I'm still running
> > --init-extent-tree as I send this email so if I should end that,
> > please let me know.

--0000000000007f7c5b0621fa5a08
Content-Type: application/octet-stream; name=output
Content-Disposition: attachment; filename=output
Content-Transfer-Encoding: base64
Content-ID: <f_m10c8b2p0>
X-Attachment-Id: f_m10c8b2p0

MjU5MzgyLjY5MTg4MF0gQlRSRlM6IGRldmljZSBmc2lkIDk3ZjlmMjhiLWIxY2MtNGQ3Mi04NTlj
LTg1MWE4NmVlNjRlMCBkZXZpZCAxIHRyYW5zaWQgNDY2MzgwIC9kZXYvc2RhMiBzY2FubmVkIGJ5
IG1vdW50ICgzMTYzMDkpClsyNTkzODIuNjkyMTMwXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhMik6
IGRpc2sgc3BhY2UgY2FjaGluZyBpcyBlbmFibGVkClsyNTkzODIuNjkyMTMyXSBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RhMik6IGhhcyBza2lubnkgZXh0ZW50cwpbMjU5MzgyLjkzNjkxNF0gQlRSRlMg
aW5mbyAoZGV2aWNlIHNkYTIpOiBiZGV2IC9kZXYvc2RhMiBlcnJzOiB3ciAwLCByZCAwLCBmbHVz
aCAwLCBjb3JydXB0IDIwOTk5NjU1LCBnZW4gMApbMjU5MzgyLjk2MTQwM10gQlRSRlMgaW5mbyAo
ZGV2aWNlIHNkYTIpOiBjaGVja2luZyBVVUlEIHRyZWUKWzI1OTQxMi45NjI3ODJdIC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpbMjU5NDEyLjk2Mjc4M10gV0FSTklORzogQ1BV
OiA0IFBJRDogMzE2MzI5IGF0IGZzL2J0cmZzL2V4dGVudC10cmVlLmM6MjMyIGJ0cmZzX2xvb2t1
cF9leHRlbnRfaW5mbysweDNjZS8weDNmMCBbYnRyZnNdClsyNTk0MTIuOTYyODEzXSBNb2R1bGVz
IGxpbmtlZCBpbjogdGxzIHNuZF9zZXFfZHVtbXkgc25kX2hydGltZXIgeGZzIGpmcyB6ZnMoUE8p
IHp1bmljb2RlKFBPKSB6enN0ZChPKSB6bHVhKE8pIHphdmwoUE8pIGljcChQTykgemNvbW1vbihQ
Tykgem52cGFpcihQTykgc3BsKE8pIGJ0cmZzIGludGVsX3JhcGxfbXNyIGludGVsX3JhcGxfY29t
bW9uIGludGVsX3RjY19jb29saW5nIHg4Nl9wa2dfdGVtcF90aGVybWFsIGludGVsX3Bvd2VyY2xh
bXAgY29yZXRlbXAgYmxha2UyYl9nZW5lcmljIHhvciB6c3RkX2NvbXByZXNzIHNuZF9oZGFfY29k
ZWNfcmVhbHRlayBrdm1faW50ZWwgc25kX2hkYV9jb2RlY19nZW5lcmljIHNuZF9oZGFfY29kZWNf
aGRtaSBsZWR0cmlnX2F1ZGlvIGt2bSBzbmRfdXNiX2F1ZGlvIHNuZF9oZGFfaW50ZWwgc25kX2lu
dGVsX2RzcGNmZyBzbmRfaW50ZWxfc2R3X2FjcGkgc25kX2hkYV9jb2RlYyByYWlkNl9wcSBsaWJj
cmMzMmMgc25kX2hkYV9jb3JlIHNuZF91c2JtaWRpX2xpYiBtYyBzbmRfaHdkZXAgc25kX3BjbSBz
bmRfc2VxX21pZGkgc25kX3NlcV9taWRpX2V2ZW50IHNuZF9yYXdtaWRpIGlucHV0X2xlZHMgc25k
X3NlcSBtZWlfaGRjcCBzbmRfc2VxX2RldmljZSBzbmRfdGltZXIgc25kIG1laV9tZSByYXBsIG1l
aSBpbnRlbF9jc3RhdGUgaW50ZWxfd21pX3RodW5kZXJib2x0IHNvdW5kY29yZSBlZTEwMDQgbWFj
X2hpZCBhY3BpX3BhZCBhY3BpX3RhZCBzY2hfZnFfY29kZWwgbXNyIHBhcnBvcnRfcGMgcHBkZXYg
bHAgcGFycG9ydCBlZmlfcHN0b3JlIHJhbW9vcHMgcHN0b3JlX2JsayByZWVkX3NvbG9tb24gcHN0
b3JlX3pvbmUgaXBfdGFibGVzIHhfdGFibGVzIGF1dG9mczQgb3ZlcmxheSBpc29mcyBkbV9taXJy
b3IgZG1fcmVnaW9uX2hhc2ggZG1fbG9nIGhpZF9sb2dpdGVjaF9oaWRwcCBoaWRfbG9naXRlY2hf
ZGogdWFzIGhpZF9nZW5lcmljIHVzYmhpZCBoaWQgdXNiX3N0b3JhZ2UgYW1kZ3B1IG14bV93bWkg
aW9tbXVfdjIKWzI1OTQxMi45NjI4NTRdICBncHVfc2NoZWQgaTJjX2FsZ29fYml0IGRybV90dG1f
aGVscGVyIHR0bSBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3BjbG11bCBnaGFzaF9jbG11bG5pX2lu
dGVsIGRybV9rbXNfaGVscGVyIGkyY19pODAxIHN5c2NvcHlhcmVhIHN5c2ZpbGxyZWN0IHN5c2lt
Z2JsdCBmYl9zeXNfZm9wcyBhZXNuaV9pbnRlbCBjZWMgY3J5cHRvX3NpbWQgY3J5cHRkIHJjX2Nv
cmUgaTJjX3NtYnVzIHI4MTY5IGRybSBhaGNpIHhoY2lfcGNpIHJlYWx0ZWsgbGliYWhjaSB4aGNp
X3BjaV9yZW5lc2FzIHdtaSB2aWRlbwpbMjU5NDEyLjk2Mjg2N10gQ1BVOiA0IFBJRDogMzE2MzI5
IENvbW06IGJ0cmZzLXRyYW5zYWN0aSBUYWludGVkOiBQICAgICAgICBXICBPICAgICAgNS4xNS4w
LTc2LWdlbmVyaWMgIzgzLVVidW50dQpbMjU5NDEyLjk2Mjg2OV0gSGFyZHdhcmUgbmFtZTogTWlj
cm8tU3RhciBJbnRlcm5hdGlvbmFsIENvLiwgTHRkLiBNUy03QjQ4L1ozNzAtQSBQUk8gKE1TLTdC
NDgpLCBCSU9TIDIuRDMgMTEvMTgvMjAyMQpbMjU5NDEyLjk2Mjg2OV0gUklQOiAwMDEwOmJ0cmZz
X2xvb2t1cF9leHRlbnRfaW5mbysweDNjZS8weDNmMCBbYnRyZnNdClsyNTk0MTIuOTYyODkxXSBD
b2RlOiAxOCA0OCAwOSA0NSA4OCA0OSA2MyA4NyA4NCAwMCAwMCAwMCA0YyA4OSBjNyA0OCAwMSBj
MyBjNiAwNyAwMCAwZiAxZiA0MCAwMCA0YyA4OSBmNyBlOCBlYiA3ZiBhOSBjZiBlYiA5MSA0OCA4
NSBkYiA3NSBkZCAwZiAwYiA8MGY+IDBiIGU5IDBjIGZmIGZmIGZmIGI4IGY0IGZmIGZmIGZmIGU5
IDMxIGZmIGZmIGZmIGU4IDBjIGRkIGE4IGNmClsyNTk0MTIuOTYyODkyXSBSU1A6IDAwMTg6ZmZm
ZmE5OGQwNjczN2FjMCBFRkxBR1M6IDAwMDEwMjQ2ClsyNTk0MTIuOTYyODk0XSBSQVg6IDAwMDAw
MDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDAwMzAwMWQxMDAwMApb
MjU5NDEyLjk2Mjg5NV0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAyZGE4ZmE2NDAw
MCBSREk6IGZmZmY5NTUxMTVkODhiNzgKWzI1OTQxMi45NjI4OTZdIFJCUDogZmZmZmE5OGQwNjcz
N2I0OCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZmZmOTU1MzVjNWVmNGQwClsyNTk0MTIu
OTYyODk3XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjog
ZmZmZjk1NTM1YzVlZjRkMApbMjU5NDEyLjk2Mjg5OF0gUjEzOiBmZmZmOTU1MTE1ZDg4Yjc4IFIx
NDogZmZmZjk1NTExNWQ4OGEwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDAKWzI1OTQxMi45NjI4OTld
IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTU1ODRlZDAwMDAwKDAwMDApIGtu
bEdTOjAwMDAwMDAwMDAwMDAwMDAKWzI1OTQxMi45NjI5MDBdIENTOiAgMDAxMCBEUzogMDAwMCBF
UzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKWzI1OTQxMi45NjI5MDFdIENSMjogMDAwMDU1
YTMwYjlmNWZmMCBDUjM6IDAwMDAwMDAyOGU0MTAwMDUgQ1I0OiAwMDAwMDAwMDAwMzcwNmUwClsy
NTk0MTIuOTYyOTAyXSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAw
IERSMjogMDAwMDAwMDAwMDAwMDAwMApbMjU5NDEyLjk2MjkwMl0gRFIzOiAwMDAwMDAwMDAwMDAw
MDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKWzI1OTQxMi45
NjI5MDNdIENhbGwgVHJhY2U6ClsyNTk0MTIuOTYyOTA0XSAgPFRBU0s+ClsyNTk0MTIuOTYyOTA2
XSAgdXBkYXRlX3JlZl9mb3JfY293KzB4MTczLzB4MzIwIFtidHJmc10KWzI1OTQxMi45NjI5Mjhd
ICBfX2J0cmZzX2Nvd19ibG9jaysweDIyYy8weDVjMCBbYnRyZnNdClsyNTk0MTIuOTYyOTQ3XSAg
YnRyZnNfY293X2Jsb2NrKzB4ZjkvMHgxODAgW2J0cmZzXQpbMjU5NDEyLjk2Mjk2N10gIGJ0cmZz
X3NlYXJjaF9zbG90KzB4NzQyLzB4ZDkwIFtidHJmc10KWzI1OTQxMi45NjI5ODddICBidHJmc19s
b29rdXBfaW5vZGUrMHgzZS8weGMwIFtidHJmc10KWzI1OTQxMi45NjMwMDhdICA/IGJ0cmZzX2Rl
bGF5ZWRfaW5vZGVfcmVsZWFzZV9tZXRhZGF0YSsweGI5LzB4YzAgW2J0cmZzXQpbMjU5NDEyLjk2
MzAzOV0gIF9fYnRyZnNfdXBkYXRlX2RlbGF5ZWRfaW5vZGUrMHg2Zi8weDJhMCBbYnRyZnNdClsy
NTk0MTIuOTYzMDY3XSAgX19idHJmc19ydW5fZGVsYXllZF9pdGVtcysweDFiZi8weDI5MCBbYnRy
ZnNdClsyNTk0MTIuOTYzMDk1XSAgYnRyZnNfcnVuX2RlbGF5ZWRfaXRlbXMrMHgxMy8weDIwIFti
dHJmc10KWzI1OTQxMi45NjMxMjJdICBidHJmc19jb21taXRfdHJhbnNhY3Rpb24rMHgyMWEvMHhh
YTAgW2J0cmZzXQpbMjU5NDEyLjk2MzE1N10gID8gc3RhcnRfdHJhbnNhY3Rpb24rMHhkMS8weDVi
MCBbYnRyZnNdClsyNTk0MTIuOTYzMTc5XSAgPyBfX2JwZl90cmFjZV9pdGltZXJfc3RhdGUrMHgy
MC8weDIwClsyNTk0MTIuOTYzMTgyXSAgdHJhbnNhY3Rpb25fa3RocmVhZCsweDEzYy8weDFiMCBb
YnRyZnNdClsyNTk0MTIuOTYzMjA0XSAgPyBidHJmc19jbGVhbnVwX3RyYW5zYWN0aW9uLmlzcmEu
MCsweDNjMC8weDNjMCBbYnRyZnNdClsyNTk0MTIuOTYzMjI1XSAga3RocmVhZCsweDEyNy8weDE1
MApbMjU5NDEyLjk2MzIyOF0gID8gc2V0X2t0aHJlYWRfc3RydWN0KzB4NTAvMHg1MApbMjU5NDEy
Ljk2MzIzMF0gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwClsyNTk0MTIuOTYzMjMzXSAgPC9UQVNL
PgpbMjU5NDEyLjk2MzIzM10gLS0tWyBlbmQgdHJhY2UgYjMxMTczNzVhN2RhMTk2MSBdLS0tClsy
NTk0MTIuOTYzMjM1XSBCVFJGUzogZXJyb3IgKGRldmljZSBzZGEyKSBpbiB1cGRhdGVfcmVmX2Zv
cl9jb3c6Mjk2OiBlcnJubz0tMzAgUmVhZG9ubHkgZmlsZXN5c3RlbQpbMjU5NDEyLjk2MzIzOF0g
QlRSRlMgaW5mbyAoZGV2aWNlIHNkYTIpOiBmb3JjZWQgcmVhZG9ubHkKWzI1OTQxMi45NjMyNDBd
IEJUUkZTIHdhcm5pbmcgKGRldmljZSBzZGEyKTogU2tpcHBpbmcgY29tbWl0IG9mIGFib3J0ZWQg
dHJhbnNhY3Rpb24uCgo=
--0000000000007f7c5b0621fa5a08--

