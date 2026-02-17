Return-Path: <linux-btrfs+bounces-21708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJz5Nfh/lGmwFAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21708-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 15:49:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A414D4AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F90530479D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE942D1931;
	Tue, 17 Feb 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cz3swEMt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161E31076A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339715; cv=pass; b=RHn0llR2zwb1Dk/cJOtP8GNcYiXa6ANQTvqqkzDIe6PRQp1wNi5cwoR7ubBlQtrnUs/TV9zanQSGue8kfwtOrWzATx6ZJuzuzzdiIeghWXm2C5FBO8zqcBpZXpKn9sZOsO5K2EvB2w+MvuooKzMdzXedsF9JsBNKUk+82gTVX/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339715; c=relaxed/simple;
	bh=BdwdGKvnO7fFw0MoaFXmtoP5xcQ32uwyD+1ybxKNc1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehbZeLIHNIsZ1jqlcNbm5sNeFSL4I5fIdMw/JJ38TPAsXlOg7kHIBgFZ/8w8QRXxVzKuJGnbwL5X7nBH/X5Wc/ii09ob1QGeFf7zj+ypBEdx2vCFck1Ui1JzOyBVLRJrRDyxdwCH8zkp0VFleKuIAkj0INIfnKfDfUmSl0gr7eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cz3swEMt; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so3276813f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 06:48:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771339712; cv=none;
        d=google.com; s=arc-20240605;
        b=EQARCxVJHclLFE7F9iu7CcAw06/ORIIE0c34zfQKLtTwT4QAy4dcbZdlxattWWUPW3
         jIiH+cvwjJujV0t5keyWOgwpWjnRpkTZ+gXjJdzFQ1boBwAB1BMn6+1pg4mIRKJsCbzO
         in4KFOPGXwEBzbUDstPJaqcM9aNLRmmnUz6fbPYguAVsKbEzR/ObhapaIeOXG8fzz9tY
         uyoS/b+kOPRDzYyTDxs1Vvm8lu5YxrBQt8raehwcPfI4YjVPIrvkcnT0PbVnT29iVvk8
         VqcoU5CZNv2dH284b6RlKWI12D4h1SrX75csXFsJRmD6OzqtteAyyO8qMTai0fnzmBC0
         kqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        fh=rWtz7wAhCdHZZNEdmPTuHXbAphU3SZCuoBURWiq+fks=;
        b=TT5KcoiCnZtzLsMftHEFvEOhGuiXZWV5mHGm7Rs36QsYvMGR9+P6dV7Rpbg1vyKq43
         AIi7WWI/pBB0MyFPby+bUqe1wr4nj8fzN89RkmSAHaaR+rMqWRNIjvJ/Gzm2DAjfUO/G
         OVKJNaSWEQFAbRrn0vjto4EO5JMvAY+qxpucWka5caCxhyki1C7amyzjUBv6kreD8WUV
         VmdBJnYrJW0F5Zzv1A7VHU4/wr4sKe5zDqs1U87EtuZxNWMax514axCgyagALHrpM5pI
         4oro8uaQBYKcD+lZx8sJBkYqhIunWyCEPJKaaKIBXKjcBbsVidtiYk3mveXx+9Y86cyk
         pQ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771339712; x=1771944512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        b=cz3swEMtk3PN2RvOTaW1z9hz0lQ4TdrxSP5U4gFFonwIFdUREVJHg2O0IHPFiUgqAI
         /uLteasIn9nknhnHTDUkGJRc/i5uKsLd3jaXqFXT6zVXHjGWz3C3yloiJNOqXQcqBBsV
         jCokeQ61LqCfTqKJ2wcPo/zgjmO2BiS6tkgRih/Gi0XRIYCABxADDHT98I2HVyvzU/A1
         djJbUeL74d4jMn70Bev0C9NAjMdbKk7xepPqG4QNTrbsgHaylLMgTa9tfmO37CODknEu
         +E1/4EBZQWP3owZXPGPNAZJoaJoGF/43yIGsyO5nvGgSTyu+nuWPqb8WztbMWQUYhWMi
         OoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771339712; x=1771944512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLr2cRWBw8S0/OXlKOzbRmg5bkPMrPDlaj10p1kdwTE=;
        b=PYVRpmb4NKxBXQueuBeJYnJ4wAg1rrTU/lm8yQubD7ft3JAPqEPVlZyR8owJsyCAIX
         WQnPPKWjT9ir1AA9EiVEVTF6nBUOFHphK2zI0a2XhvSJa7/P6Gj1ZhaDR6Qg5sU4PDr8
         Et/M4xBMPuVmlfcjeUoLmID1SNW8IE+79V62pwhONqYyzUS0lKGj56bJ80ZiOuY5UHvQ
         3q0jsNjwEeLRw/RJWc1IStSodOTJYeee+CVJ6Q0UoG6ghqYLY48lKGoNHgVqI6R+UYFl
         Wk9RTssIM4+kp/fJs0wEE4NoYssG96UsPgLhvCm197x64DzO6VSdhENhSV197nEZxk+S
         TG2g==
X-Forwarded-Encrypted: i=1; AJvYcCXqi1IetzxR5zIC2MI+uWgiFXX/hRXZR/BCG0QC3xGDXE76MmoYV5VsQ+q1/KBQnEPlDJNuVwcJw6Vxgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+uYlSvF2uggkkjOe3WC21IWk/HPeYX5lDyUgod8OSjytgVMm
	fs0GKQLjPW/prRmxX8pInYAKakD04gwsgIwXmilEGS20aVKCtzXPwIZNeonAH91FC6qS2aTmNGz
	4Z16v4P97qwLENwZe5KkxxLOldDb9iUf2UzZMgbcTejCivjbnAzbM
X-Gm-Gg: AZuq6aLXvjfxHQjt2tP8StL/2P7dfxj0zo3C25IE8xlqLoorf5wofO987F5Z54nN2Z+
	DOIIni50dQFK7lQqe+bPxDbg0R4JxMOTu9bdWQf5K+Q+fNHD/wAQxonuhjba4unlMvsAYFcd3AI
	5lBltdmS6m7Ndc0LLC9cdtPHTmyffc/+Yo77Ih7T+sPabM/7uZtKj4mlBjReWloRBmLorseSyxX
	kkPzDfchQUflXI6K2Vx11J9+yhtDlr+XXHGwvX5feyJ4HwyCCgerrR9BPXlsONl3DCYy99UiRvi
	kbumaF0wpZJOPtc669HfLxXc/6fB49BwRZWzMT2lbA/4cD9SpY85Q6lXBpgCWX9j2xbDtyNh/mP
	L7h0C
X-Received: by 2002:a05:6000:1a8e:b0:435:8f88:7235 with SMTP id
 ffacd0b85a97d-4379790e98amr27190797f8f.33.1771339711651; Tue, 17 Feb 2026
 06:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-9-neelx@suse.com>
 <64126c50-063e-40e4-a536-233cce94b65e@infradead.org>
In-Reply-To: <64126c50-063e-40e4-a536-233cce94b65e@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 17 Feb 2026 15:48:20 +0100
X-Gm-Features: AaiRm51hHUsbfTUEHtSwC9qIQM4TJ160IJ28Zz9PQrmVkFY3H02cMBpf6HPloMc
Message-ID: <CAPjX3FfLFDS5Q32BzbhPgohsX250f8+JX_YbKPLVaGqVGcfV6g@mail.gmail.com>
Subject: Re: [PATCH v6 08/43] fscrypt: add documentation about extent encryption
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,infradead.org:email,mail.gmail.com:mid,toxicpanda.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21708-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 5B8A414D4AD
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 at 19:43, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/6/26 10:22 AM, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Add a couple of sections to the fscrypt documentation about per-extent
> > encryption.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >
> > v5: https://lore.kernel.org/linux-btrfs/7b2cc4dd423c3930e51b1ef5dd209164ff11c05a.1706116485.git.josef@toxicpanda.com/
> >  * No changes since.
> > ---
> >  Documentation/filesystems/fscrypt.rst | 41 +++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > index 70af896822e1..8afec55dd913 100644
> > --- a/Documentation/filesystems/fscrypt.rst
> > +++ b/Documentation/filesystems/fscrypt.rst
> > @@ -283,6 +283,21 @@ alternative master keys or to support rotating master keys.  Instead,
> >  the master keys may be wrapped in userspace, e.g. as is done by the
> >  `fscrypt <https://github.com/google/fscrypt>`_ tool.
> >
> > +Per-extent encryption keys
> > +--------------------------
> > +
> > +For certain file systems, such as btrfs, it's desired to derive a
> > +per-extent encryption key.  This is to enable features such as snapshots
> > +and reflink, where you could have different inodes pointing at the same
> > +extent.  When a new extent is created fscrypt randomly generates a
> > +16-byte nonce and the file system stores it along side the extent.
>
>                                                alongside
>
> > +Then, it uses a KDF (as described in `Key derivation function`_) to
> > +derive the extent's key from the master key and nonce.
> > +
> > +Currently the inode's master key and encryption policy must match the
> > +extent, so you cannot share extents between inodes that were encrypted
> > +differently.
> > +
> >  DIRECT_KEY policies
> >  -------------------
> >
> > @@ -1488,6 +1503,27 @@ by the kernel and is used as KDF input or as a tweak to cause
> >  different files to be encrypted differently; see `Per-file encryption
> >  keys`_ and `DIRECT_KEY policies`_.
> >
> > +Extent encryption context
> > +-------------------------
> > +
> > +The extent encryption context mirrors the important parts of the above
> > +`Encryption context`_, with a few ommisions.  The struct is defined as
>
>                                      omissions
>
> > +follows::
> > +
> > +        struct fscrypt_extent_context {
> > +                u8 version;
> > +                u8 encryption_mode;
> > +                u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
> > +                u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> > +        };
> > +
> > +Currently all fields much match the containing inode's encryption
> > +context, with the exception of the nonce.
> > +
> > +Additionally extent encryption is only supported with
> > +FSCRYPT_EXTENT_CONTEXT_V2 using the standard policy, all other policies
>
>                                                 policy; all other policies
>
> > +are disallowed.
> > +
> >  Data path changes
> >  -----------------
> >
> > @@ -1511,6 +1547,11 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
> >  buffers regardless of encryption.  Other filesystems, such as ext4 and
> >  F2FS, have to allocate bounce pages specially for encryption.
> >
> > +Inline encryption is not optional for extent encryption based file
> > +systems, the amount of objects required to be kept around is too much.
>
>    systems; the amount of

Thanks Randy. I'll amend all these in the next iteration.

--nX

> > +Inline encryption handles the object lifetime details which results in a
> > +cleaner implementation.
> > +
> >  Filename hashing and encoding
> >  -----------------------------
> >
>
> --
> ~Randy
>

