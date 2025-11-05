Return-Path: <linux-btrfs+bounces-18741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5CC37619
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C591A21E2D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1968301705;
	Wed,  5 Nov 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kpgzigv0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558D243376
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368649; cv=none; b=WfwtAm2wyabV0GRLDgDBKnQ34lW0NmFnzKWnhmIgLB61cSlTLcJO6Iegw6qKct3BO3tGhJokneTufemkoILNjiDbIRJCoZeNhJPUmXry1qUW/K4J7B2xNKK/vxP55bybh9cKbMTj15yvsrcPKmxuIdBWW3FNZOwh0iPNmjkhtF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368649; c=relaxed/simple;
	bh=AR3Tr51DEIZpKjlHia+yL3++n71VyHBWu/YGG/C5b8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1mkJOhBbTO4uzgmXGUmpvS1vP8Dyhwiji+p4iFxwWej18FbeAn/OX/k8utjTdiND29DEAMjZ1tj4b9FGvs0eoca1WRaoNxLEp41c5wwRGdykxJBJWnD9W07F10SylCP7jXzReF8BydNnbFuCCzfza9oMkzCRH8wCxeTlKKV9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kpgzigv0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so133544f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 10:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762368645; x=1762973445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O71bTvl8ycrFadW+n507Eymg3koTfCjZxvdMhis1QVs=;
        b=Kpgzigv0S1IIys/wQWAoM2CgU4JWlK9M+bqMSllxZtpBUaOk5KuzPcLwKs/v1xUHU1
         /HfqvK+Btn82+Yck3ghcgZRxnrAMWjMeN1lnx5Y2aU89IWdroSzvL0G/HpqIpHkXh7A3
         cMFH2sxBFPyv7/MvtqyPxh4vx20v+Olmky2iI2WTwJlpZWIPLg5qTLMoXJoS1C000a3j
         j9HHg9z+0ri+ZNKUbTU/IMFeAgn6mQZ49SZcjFPEO7d7vceU6N5w+sYERmrAJXEXSZ1v
         8SvTO/LqUSfUg24WXMs/IXL8OBMaxV/vuNi3EHxywO0/+fENsTel9F4LggKjjfDwDAPv
         MDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368645; x=1762973445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O71bTvl8ycrFadW+n507Eymg3koTfCjZxvdMhis1QVs=;
        b=VbdAVZ6dIBUAzxCugNIv+9d7XPsRY+5bPqE5Phfu1lLRV8xUywRyS+tFikCG8J1LNH
         pd3FGPF4VqQzMjmnKI+zU5D4KvA+8v9bxO30ka6wRRMyVRThNRuknmf+rpEc1BN4lW74
         cBMlylu5jxJcIp1f42uEPYqGEcJ2PnCQdY5pp/YBURltcVCgID1H2tpIznfLrxVAwkTf
         u76Dpl6AMl57HQ0EfFUONlOtd0J5//5emDaCCV12aKlMiSsT53GTyN+mFp4qNlpUBraH
         6BIeBQNIVH9KVnQ+Eh68vTpytsVpaD6AX4uT+c1un6pr1doGC+yp/e1u1Ar4RrQa5jPa
         I7pw==
X-Forwarded-Encrypted: i=1; AJvYcCW79mdnCeI/kdb7x1M7x6qFBskKnr6rNNanMuONd4lSgd6qbJtvucXPetl0qHkbe7ugW/zoAgb9Y3XdDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgJ1O8Wybe8vEoDmYW3WOYSYG6MVpDOB/eNXC/1MySNAG9KRU
	C6vU2gqOsW9q0wiyymuuPdhfLJY7LY0dFz6hNkbVjJ8AI0bot3VArJgOm6aNP8VbayE3BZ4Cjxu
	5P5YqUoHB08LkHmM1KAiYMfZdpffFNBquP50EGeFFBg==
X-Gm-Gg: ASbGncuQIsXfHQcevsQxfJd6ObwKETZAEYgTnv0JcCRcoervm7LR6gJkESlVx4BwuV4
	DIyQmHTn1XV/HpzteQ3gZcyhWgTcTV5U3S4/80AEWOyemJE7AcVlJ54UmbJLh9xL/C9lB6sBF5K
	CkaiFkWN9t/cgB/MiVYqMlEd0q/Vr5YpqlW6QmHhkwkLW5R7R6bk1r3ultKiBkfy+JxWJtlRjWc
	V6XdOlOlWLP+FVJrVCXKoSE2qnVL8TNLwgqjI8ym4QvqqYcjhZNvSF0TEGHAouhMGWWU3CzeSw2
	b2nVaAsi2XMp+3r1gwW50cecITzocLFImYmBvgt4RCw4AMPK24vbIivhVg==
X-Google-Smtp-Source: AGHT+IEl+wf0FPgtypwBcsggq27T8diJ+W4afYGT2ObX692cZJu0dO8J1HpGnirBYZxDCql0kT1HlaQuaW0+Uyzc6f4=
X-Received: by 2002:a05:6000:26c2:b0:429:cc6b:e011 with SMTP id
 ffacd0b85a97d-429e33063b4mr3794933f8f.36.1762368645525; Wed, 05 Nov 2025
 10:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762142636.git.wqu@suse.com> <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
 <aQiXObERFgW3aVcE@infradead.org> <i5ju5ohsvi54bsgfeuoy22tniln2scxwwl77iuluho5ohqn527@ycwgvf4yclwe>
In-Reply-To: <i5ju5ohsvi54bsgfeuoy22tniln2scxwwl77iuluho5ohqn527@ycwgvf4yclwe>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:50:34 +0100
X-Gm-Features: AWmQ_bn9cmWhEGY2XKLOcbegApB5i6cnfvYmKdk0xlLIg2P37-OrpResm_bmKrQ
Message-ID: <CAPjX3FdpED=XmQy_a6Py=rGh_OoGXXGhBCA_mqAFWAdr=c1S5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] fs: do not pass a parameter for sync_inodes_one_sb()
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 09:50, Jan Kara <jack@suse.cz> wrote:
>
> On Mon 03-11-25 03:51:21, Christoph Hellwig wrote:
> > On Mon, Nov 03, 2025 at 02:37:28PM +1030, Qu Wenruo wrote:
> > > The function sync_inodes_one_sb() will always wait for the writeback,
> > > and ignore the optional parameter.
> >
> > Indeed.
>
> Yeah, apparently I've broken non-blocking nature of emergency sync without
> nobody noticing for 13 years. Which probably means the non-blocking logic
> isn't that important ;)...

Or it means it's not being widely tested or used heavily in production
and when it fails it's hard to tell if that was because it is broken
or because the system state was already severely impaired at that
time.

--nX

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

