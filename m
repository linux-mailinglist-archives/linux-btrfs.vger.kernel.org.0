Return-Path: <linux-btrfs+bounces-3329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15587D4C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 21:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B028436F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8001535B9;
	Fri, 15 Mar 2024 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="dn9ufNa5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB11F19A
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532919; cv=none; b=AYBBtG6ZG9G025Ah8fAZ4zKypZqr3CY2FiXa00dLFpPOV1wjfRxQqFd76lCVSVXJrjLZRxO7knk9zva+JW64J3H6TyKhGybhrHcgzrfV2jhuUB26Ff0sGeI6hgCYLr/EN0JzvSnR5IAbuMoANea00RiOCksQ7DtL/WW63pYOrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532919; c=relaxed/simple;
	bh=9PCcGaRFuR3zSeSzi+zdHmxHJxYdtVOrsajMuMzGfa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTpwz1QJjNbJKK8IqbLE1uDYdjrgMu93otaKY7QzqYzV/Xr0aB3Lfawmgkpx6P4AOWztbM5E7iw+OBPRxXxsPOOHLSUl4JFVQ9UOhJgwe4uA88xitKOiq567jEIrmHwDXhBblygu2dtFkRbPnfqfU4C0Gyq5Iwq7NByEDjdjwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=dn9ufNa5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690d054fff2so15680416d6.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1710532915; x=1711137715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkk6snqOLo8TlzCqIyL7i2u7tXTax9jTKHYDo38YOKE=;
        b=dn9ufNa5RmNc2zRxidLHlNmtFpdzeh/6/mOx19kMLqmCTw/mLqjRQX9xvsZzodjlgC
         ZY+XTRbzpcgn3/VhUtcvMsUDp4wNUeHAdHTxxFhvejD30lMDajLF3j28aJLkqeDaowna
         TRH2z6LuvyDSTTkK3mVThmvGRnu531ZNeoU8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532915; x=1711137715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nkk6snqOLo8TlzCqIyL7i2u7tXTax9jTKHYDo38YOKE=;
        b=ajQaLDjckVaTx/bPE9hXHl/4WhPf/M86yXImwNCb0w5qCfKUREIkp2uq+L6Zyh/5Y/
         TFJcpUf91HfP2iBVTunp2DEY+Nl6KohQORkpjOphT/+/Eb16CssJOU8Mc2SppIq3U4lr
         yMFmPgwsmkpE6p0QFaSZPZdvbm+7jk51M9d+9OaebZFjTbaSKHMkK5Q7WWhkBRfmSxAI
         tTI6aWuRw4QdqXULPIXu7WTzUNO3TDxKjVEdZa6ADzKP0498lBJHcw7PSxmEDageWqYw
         2CVtuD6nNcFLADzF8pQVjNPvHYP516m9OjVF3fm5HBErYDX8utfniWy3osJHKYf8A09w
         ygzg==
X-Gm-Message-State: AOJu0YyUApe1P5X8RdlWIh2Gs+JIc3X0afbt/x7xagOMa3w3afIyHKes
	5JcFeYLWx1G5I+mIcN+KumnQzmHF1n/qwtRSaDy1B66NeBm58epUq7EATMtXzWYyre7hKBb7vME
	k4/zgIE3+vxfCDz/vcJ7jrZZqzOwgjA8NyXM=
X-Google-Smtp-Source: AGHT+IGCuSo0u/DWyyFGTWXkx7CdPoLQ/5l7028WE+MIEuGDZjvk9osc4peXvba65pbgHJUkrgYwyd8bmxtQV/DzOyQ=
X-Received: by 2002:a0c:e141:0:b0:690:b6b2:b5b1 with SMTP id
 c1-20020a0ce141000000b00690b6b2b5b1mr5676253qvl.37.1710532914731; Fri, 15 Mar
 2024 13:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com> <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
In-Reply-To: <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Fri, 15 Mar 2024 16:01:43 -0400
Message-ID: <CABg4E-mRsvA5DWnwajpQzr2dbb6Efv=wxP+KCyVYHd2OqiMP_w@mail.gmail.com>
Subject: Re: About the weird tree block corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c296630613b87afd"

--000000000000c296630613b87afd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:23=E2=80=AFAM Tavian Barnes
<tavianator@tavianator.com> wrote:
> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
> > [SNIP]
> >
> > The second patch is to making tree-checker to BUG_ON() when something
> > went wrong.
> > This patch should only be applied if you can reliably reproduce it
> > inside a VM.
>
> Okay, I have finally reproduced this in a VM.  I had to add this hunk
> to your patch 0002 in order to trigger the BUG_ON:
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c8fbcae4e88e..4ee7a717642a 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -2047,6 +2051,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>                                 btrfs_header_level(eb) =3D=3D 0 ? "leaf" =
: "node",
>                                 root_owner, btrfs_header_bytenr(eb), eb_o=
wner,
>                                 root_owner);
> +                       BUG_ON(1);
>                         return -EUCLEAN;
>                 }
>                 return 0;
> @@ -2062,6 +2067,7 @@ int btrfs_check_eb_owner(const struct
> extent_buffer *eb, u64 root_owner)
>                         btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "node"=
,
>                         root_owner, btrfs_header_bytenr(eb), eb_owner,
>                         BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJECT=
ID);
> +               BUG_ON(1);
>                 return -EUCLEAN;
>         }
>         return 0;
>
> > When using the 2nd patch, it's strongly recommended to enable the
> > following sysctl:
> >
> >   kernel.ftrace_dump_on_oops =3D 1
> >   kernel.panic =3D 5
> >   kernel.panic_on_oops =3D 1
>
> I also set kernel.oops_all_cpu_backtrace =3D 1, and ran with nowatchdog,
> otherwise I got watchdog backtraces (due to slow console) interspersed
> with the traces which was hard to read.
>
> > And you need a way to reliably access the VM (either netconsole or a
> > serial console setup).
> > In that case, you would got all the ftrace buffer to be dumped into the
> > netconsole/serial console.
> >
> > This has the extra benefit of reducing the noise. But really needs a
> > reliable VM setup and can be a little tricky to setup.
>
> I got this to work, the console logs are attached.  I added
>
>     echo 1 > $tracefs/buffer_size_kb
>
> otherwise it tried to dump 48MiB over the serial console which I
> didn't have the patience for.  Hopefully that's a big enough buffer, I
> can re-run it if you need more logs.
>
> > Feel free to ask for any extra help to setup the environment, as you're
> > our last hope to properly pin down the bug.
>
> Hopefully this trace helps you debug this.  Let me know whenever you
> have something else for me to test.
>
> I can also try to send you the VM, but I'm not sure how to package it
> up exactly.  It has two (emulated) NVMEs with LUKS and BTRFS raid0 on
> top.

I added eb->start to the "corrupted node/leaf" message so I could look
for relevant lines in the trace output.  From another run, I see this:

$ grep 'eb=3D15302115328' typescript-5
[ 2725.113804] BTRFS critical (device dm-0): corrupted leaf, root=3D258
block=3D15302115328 owner mismatch, have 13709377558419367261 expect
[256, 18446744073709551360] eb=3D15302115328
[ 2740.240046] iou-wrk--173727   15..... 2649295481us :
alloc_extent_buffer: alloc_extent_buffer: alloc eb=3D15302115328
len=3D16384
[ 2740.301767] kworker/-322      15..... 2649295735us :
end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D3 eb level=3D0
fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
[ 2740.328424] kworker/-5095     31..... 2649295941us :
end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D8 eb level=3D0
fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000

I am surprised to see two end_bbio_meta_read lines with only one
matching alloc_extent_buffer.  That made me check the locking in
read_extent_buffer_pages() again, and I think I may have found
something.

Let's say we get two threads simultaneously call
read_extent_buffer_pages() on the same eb.  Thread 1 starts reading:

    if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
        return 0;

    /*
     * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
     * operation, which could potentially still be in flight.  In this case
     * we simply want to return an error.
     */
    if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
        return -EIO;

    /* (Thread 2 pre-empted here) */

    /* Someone else is already reading the buffer, just wait for it. */
    if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
        goto done;
    ...

Meanwhile, thread 2 does the same thing but gets preempted at the
marked point, before testing EXTENT_BUFFER_READING.  Now the read
finishes, and end_bbio_meta_read() does

            btrfs_folio_set_uptodate(fs_info, folio, start, len);
    ...
    clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
    smp_mb__after_atomic();
    wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);

Now thread 2 resumes executing, atomically sets EXTENT_BUFFER_READING
(again) and starts reading into the already-filled-in extent buffer.
This might normally be a benign race, except end_bbio_meta_read() has
also set EXTENT_BUFFER_UPTODATE.  So now if a third thread tries to
read the same extent buffer, it will do

    if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
        return 0;

and return 0 *while the eb is still under I/O*.  The caller will then
try to read data from the extent buffer which is concurrently being
updated by the extra read started by thread 2.

I attached a candidate patch.  So far only compile-tested.

--=20
Tavian Barnes

--000000000000c296630613b87afd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-btrfs-Double-check-EXTENT_BUFFER_UPTODATE.patch"
Content-Disposition: attachment; 
	filename="0001-btrfs-Double-check-EXTENT_BUFFER_UPTODATE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltt33zgx0>
X-Attachment-Id: f_ltt33zgx0

RnJvbSA1MGFiMmYyOTNmYWMxNTYwODQwYjQ1MjI4NzE5YzAzMTBiMDVkMWM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8NTBhYjJmMjkzZmFjMTU2MDg0MGI0NTIyODcxOWMw
MzEwYjA1ZDFjOS4xNzEwNTMyODU4LmdpdC50YXZpYW5hdG9yQHRhdmlhbmF0b3IuY29tPgpGcm9t
OiBUYXZpYW4gQmFybmVzIDx0YXZpYW5hdG9yQHRhdmlhbmF0b3IuY29tPgpEYXRlOiBGcmksIDE1
IE1hciAyMDI0IDE2OjAwOjA3IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gYnRyZnM6IERvdWJsZS1j
aGVjayBFWFRFTlRfQlVGRkVSX1VQVE9EQVRFCgpTaWduZWQtb2ZmLWJ5OiBUYXZpYW4gQmFybmVz
IDx0YXZpYW5hdG9yQHRhdmlhbmF0b3IuY29tPgotLS0KIGZzL2J0cmZzL2V4dGVudF9pby5jIHwg
MjAgKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2V4dGVudF9pby5jIGIvZnMv
YnRyZnMvZXh0ZW50X2lvLmMKaW5kZXggNzQ0MTI0NWIxY2ViLi5lNTA2Y2JmYmNiMWIgMTAwNjQ0
Ci0tLSBhL2ZzL2J0cmZzL2V4dGVudF9pby5jCisrKyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jCkBA
IC00MjcwLDYgKzQyNzAsMTMgQEAgdm9pZCBzZXRfZXh0ZW50X2J1ZmZlcl91cHRvZGF0ZShzdHJ1
Y3QgZXh0ZW50X2J1ZmZlciAqZWIpCiAJfQogfQogCitzdGF0aWMgdm9pZCBjbGVhcl9leHRlbnRf
YnVmZmVyX3JlYWRpbmcoc3RydWN0IGV4dGVudF9idWZmZXIgKmViKQoreworCWNsZWFyX2JpdChF
WFRFTlRfQlVGRkVSX1JFQURJTkcsICZlYi0+YmZsYWdzKTsKKwlzbXBfbWJfX2FmdGVyX2F0b21p
YygpOworCXdha2VfdXBfYml0KCZlYi0+YmZsYWdzLCBFWFRFTlRfQlVGRkVSX1JFQURJTkcpOwor
fQorCiBzdGF0aWMgdm9pZCBlbmRfYmJpb19tZXRhX3JlYWQoc3RydWN0IGJ0cmZzX2JpbyAqYmJp
bykKIHsKIAlzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIgPSBiYmlvLT5wcml2YXRlOwpAQCAtNDMw
NCw5ICs0MzExLDcgQEAgc3RhdGljIHZvaWQgZW5kX2JiaW9fbWV0YV9yZWFkKHN0cnVjdCBidHJm
c19iaW8gKmJiaW8pCiAJCWJpb19vZmZzZXQgKz0gbGVuOwogCX0KIAotCWNsZWFyX2JpdChFWFRF
TlRfQlVGRkVSX1JFQURJTkcsICZlYi0+YmZsYWdzKTsKLQlzbXBfbWJfX2FmdGVyX2F0b21pYygp
OwotCXdha2VfdXBfYml0KCZlYi0+YmZsYWdzLCBFWFRFTlRfQlVGRkVSX1JFQURJTkcpOworCWNs
ZWFyX2V4dGVudF9idWZmZXJfcmVhZGluZyhlYik7CiAJZnJlZV9leHRlbnRfYnVmZmVyKGViKTsK
IAogCWJpb19wdXQoJmJiaW8tPmJpbyk7CkBAIC00MzMzLDYgKzQzMzgsMTUgQEAgaW50IHJlYWRf
ZXh0ZW50X2J1ZmZlcl9wYWdlcyhzdHJ1Y3QgZXh0ZW50X2J1ZmZlciAqZWIsIGludCB3YWl0LCBp
bnQgbWlycm9yX251bSwKIAlpZiAodGVzdF9hbmRfc2V0X2JpdChFWFRFTlRfQlVGRkVSX1JFQURJ
TkcsICZlYi0+YmZsYWdzKSkKIAkJZ290byBkb25lOwogCisJLyoKKwkgKiBTb21lb25lIGVsc2Ug
YWxyZWFkeSBzdGFydGVkIGFuZCBjb21wbGV0ZWQgdGhlIHJlYWQgYmV0d2VlbiB1cworCSAqIGNo
ZWNraW5nIFVQVE9EQVRFIGFuZCBSRUFESU5HLgorCSAqLworCWlmICh1bmxpa2VseSh0ZXN0X2Jp
dChFWFRFTlRfQlVGRkVSX1VQVE9EQVRFLCAmZWItPmJmbGFncykpKSB7CisJCWNsZWFyX2V4dGVu
dF9idWZmZXJfcmVhZGluZyhlYik7CisJCXJldHVybiAwOworCX0KKwogCWNsZWFyX2JpdChFWFRF
TlRfQlVGRkVSX1JFQURfRVJSLCAmZWItPmJmbGFncyk7CiAJZWItPnJlYWRfbWlycm9yID0gMDsK
IAljaGVja19idWZmZXJfdHJlZV9yZWYoZWIpOwotLSAKMi40NC4wCgo=
--000000000000c296630613b87afd--

