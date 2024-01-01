Return-Path: <linux-btrfs+bounces-1175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB782152B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jan 2024 20:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615791C20DF6
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jan 2024 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D9CDDC6;
	Mon,  1 Jan 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1U/ZHg3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4FDDA3
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jan 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704138930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fom98YZ3saOzfcMPCQNEio6JgkI9Tm86huiOm1TIpTI=;
	b=L1U/ZHg3JWHvikHzCFVvP4SOuHsB1O64LYDDTmLfT9ic8qYWXnAHImO6nfyJITRVjLwQ13
	S/qQO5kgDqwqnqFJl28pV7ySlvYOD7lX7sUJYwyJPaZWSwWSab6tUnpf8zs175E513r2vE
	Vd0qo7lrv+orBYI4D5FIT0TLerD9mug=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-FNFl1xZbOEqdE8Rwtfq2oA-1; Mon, 01 Jan 2024 14:55:29 -0500
X-MC-Unique: FNFl1xZbOEqdE8Rwtfq2oA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-204047a3789so11597853fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jan 2024 11:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704138928; x=1704743728;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fom98YZ3saOzfcMPCQNEio6JgkI9Tm86huiOm1TIpTI=;
        b=hdiiYVcTYO0dCgufn1rJ4QGY7Rm910VSxl7qCQz9xMDlrZpKXwPPA2ZIhxlwH2ZqmG
         mixBEU4LTWXgvWuFa/Y7nXpoOIporKin6gVGaCQdnG9OOAYazpvHlU3O7Gk9W/4thx3i
         1OMkSlyR3jvfA6naFSE9+9DmCL+Y/a8Xye7oTj3HGspr3MZH7/iT0MCsy9yRbpHgWPC9
         ajxEjEiw/tK5UDtz3CFVL6cLz4wSpO9RT9wtWlz4yXnML9+r7sYlg4Y/7/ih6A4L/G56
         QlJp68EX3XJhB7z/SeNUNq2pUetI9D559TmOaeSixmYjt9cDRFxM037ATR68MAjMSRjT
         JGiQ==
X-Gm-Message-State: AOJu0YxF8gIly1ella5PWSmmdtDxX4hvMCcgK0BO22dqoS25bpjTIo5n
	lelQ+Db7/GQO1YDPHHk2YjSgfFS0cfi+NqwpEhbReAfPcyQE1JD/5gLtXWGU2LFG+J69XQLqFP1
	tLq2v1RFsVskG2RRoq0vhll9KYvI5pIQ=
X-Received: by 2002:a05:6871:8210:b0:203:c722:5210 with SMTP id sp16-20020a056871821000b00203c7225210mr20073962oab.74.1704138928370;
        Mon, 01 Jan 2024 11:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7c8ZR8oiWnoADHUOdm4UGdpd3RniL9mcBAlHPE+kv5t/VY6J6FYaHasXWwHu8f8qoMWfzcA==
X-Received: by 2002:a05:6871:8210:b0:203:c722:5210 with SMTP id sp16-20020a056871821000b00203c7225210mr20073949oab.74.1704138928046;
        Mon, 01 Jan 2024 11:55:28 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm19349836pgb.34.2024.01.01.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 11:55:27 -0800 (PST)
Date: Tue, 2 Jan 2024 03:55:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/303: add git commit ID to _fixed_by_kernel_commit
Message-ID: <20240101195524.6pmsefq4welawfae@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a61891b7afa408c39921c2357d00812292068c9e.1701858258.git.fdmanana@suse.com>
 <20231209044114.znk5wbl5fuwgf5hr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H53RjEXxRXC=x_H2qZ+aaeSgoikvoirBTRdDWW0nAmHzw@mail.gmail.com>

On Fri, Dec 29, 2023 at 12:59:44PM +0000, Filipe Manana wrote:
> On Sat, Dec 9, 2023 at 4:41 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Dec 06, 2023 at 10:24:44AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > The kernel patch for this test was merged into 6.7-rc4, so replace the
> > > "xxxxxxxxxxxx" stub with the commit id.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> What happened to this patch? It was not merged in the last 2 for-next
> branch updates.

Sorry, it was missed, it'll be in next release.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > >  tests/btrfs/303 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > > index b9d6c61d..521d49d0 100755
> > > --- a/tests/btrfs/303
> > > +++ b/tests/btrfs/303
> > > @@ -15,7 +15,7 @@ _begin_fstest auto quick snapshot subvol qgroup
> > >  _supported_fs btrfs
> > >  _require_scratch
> > >
> > > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +_fixed_by_kernel_commit 8049ba5d0a28 \
> > >       "btrfs: do not abort transaction if there is already an existing qgroup"
> > >
> > >  _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > --
> > > 2.40.1
> > >
> > >
> >
> 


