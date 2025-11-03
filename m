Return-Path: <linux-btrfs+bounces-18533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F24FC2A44C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 08:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C827D3AB678
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE529ACC5;
	Mon,  3 Nov 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBvkeDKl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AF299949
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154296; cv=none; b=XdGllfvI7e0PTsVR6qQs+jKosncWs+SbqPy7ym0ZZL+C7gv7zBTUyMQMV0XK0R552J4mdy6DkWZiXrtll8Df5MH4JXEwZggmkcC4UBPzq1sgDdpqU5a59abW0V9wzWwQuH6FAlx4w1E3PvyuEAeztxktHB7fp3vHWP3J4W1K6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154296; c=relaxed/simple;
	bh=mNiBHRHLdMqnvaJIEavpx7C7tTm8CYCoyLazYi6SDLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHVHiC9ItVsZN1b1i2Nc7iGf8AvhY2Vkeil4covpaSsDwfD+MPwx/pqkm+nI4CWPq3bcF4D9gsvqP44QVM5Qre/OlcCLxGqfOxeXi9Uvky2Thmuca9Tg1cRA/7vwIF4vMTWD7B+5+CjdyTag3NDCvnzxIlc5EiqAKEqzzazS6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBvkeDKl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso25682275e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 23:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762154293; x=1762759093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=NBvkeDKlfAkIDsV3UME85lnO9awL8QzNTwhFYaIiXF9Af/y9CYyrD70ovpNljZmod3
         rFP7K3fGfVVqsaBHO6UKTsL+kif5I7mVOUCMLTCcb5wcGyYI1jGpsZKnXqYcNavXmv19
         Yr1fgqjxa6wHgu9aIKZ+qOY7FxuDKLNXa3XqLlBfAxvq5wnFec/HEXubeEttJlb6fFu3
         1/DXeHl2ZQ//HVGCciwqXamvP0mSsXWGOONj6Dxx560+qhaFySNYYjtMztf1MS0mjZll
         WHJdl+kqkVsyORk2/8wZZ8tt8O8rYf+W52e6SHEsgAvy4Z6D1ZssqXRP9yzOrjST19yM
         vmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762154293; x=1762759093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyxHa9/8/Ar3cmThFu6k2oVGwIVFxlREAcZe35Eyfc8=;
        b=uQp6pMFEjMIKA4gsKv2ditpXe23ve/2IE/IedlmbeHi8pTzOjn0Z/TUZqUf7/Gv++D
         pZfY4iD1E9O0bJY29vLgTA9iIIv/e+K7Yi+4+GULkEBYu7BzvDfde1hpnqCErxP+wYIA
         lUCYpY+S7X3mtdK60bNzq3uBTNENKqtS/IMgEw9/O3ZP8KeiyDdpYnPUupgIYmh6I1Rt
         sFu0gpfs7fzTFSBAeP0UCniJCKPYADMzKUTfRVgsHn9hlPX/JXfxS3eK2UGaLt2JSTTu
         gYG7QwPr3E07yKNzXm9DhGHdiv0lIe6XKEP3nLT0gslM2fInlfGc+c045C638nVG9X2t
         +mXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWb0MHwRVih8x3CIoYLn17rYm/UezLB2330tROY5jAppyuMd3RU6KMk86x5NYnRSjJaPOYbWMKzQE6/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYGaEKPysrwM/VHsZBRFdkw9ND01t8oVKENJztxMDSh/gtmb1
	z6Aktj8mUWxvxVzIog2Ii+ELPcCXty8/H6F8nEcF9WHsrHQcfTJXq1e6l4zBzTddRRxsk8tQF5R
	F9qeGQBYOFwkwvkiYeQtHzJklxN927BQLcAaCwd17yw==
X-Gm-Gg: ASbGncujnW+1dH8MlOu3MR6mjet8c/SPFr7A+6+gZkXjn/ZU+4cBQHCyDNY2JET0bIm
	5dZXZDobszv+oXVuVfsvFW1ew0g+0/WRhCH4007xciMdk4mzreqseIush2LV/fhnPJbKAMLrwIS
	uWWYK1lJcIdD2tAXFI3+lJgdz2hVrYWhh/RjjbBi7sLabdUCrygov1NKbsQBDSWruPiVZ7ht9q5
	lJL+htw62JteYCWSBcnEcahy4wExGYz8AZuuZ12OpK9wtJeSj+g8tecXW4GmRbQ2XaS8lmiEVvh
	ZVs1NumI4unOWKhYLD/IXHNnxQWpm8PQBPz4yYmaiQofSdlgUBlf3zGUOvrfXTN1yUSV
X-Google-Smtp-Source: AGHT+IHqUQu8mdmKFV60YUxpDIMFoEiDUTPxoVdwOa3d9A2KABNI1QO1FJGgMlmc/MHoUnrp0Cz2XrvfjpDIzK4Hz9g=
X-Received: by 2002:a05:600c:620a:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-4773bf42644mr79682075e9.7.1762154292857; Sun, 02 Nov 2025
 23:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org> <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
In-Reply-To: <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 3 Nov 2025 08:18:00 +0100
X-Gm-Features: AWmQ_bmxLu0zc6F1WlZXfm4Psv5Sxs14UirqMZbxcqRpQmruSk8F7QkSWlVIM64
Message-ID: <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>, 
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 06:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 11/1/25 02:48, Bart Van Assche wrote:
> > Hi Damien,
> >
> > disk_update_zone_resources() only has a single caller and just below the
> > only call of this function the following code is present:
> >
> >       if (ret) {
> >               unsigned int memflags = blk_mq_freeze_queue(q);
> >
> >               disk_free_zone_resources(disk);
> >               blk_mq_unfreeze_queue(q, memflags);
> >       }
> >
> > Shouldn't this code be moved into disk_update_zone_resources() such that
> > error handling happens without unfreezing and refreezing the request
> > queue?
>
> Check the code again. disk_free_zone_resources() if the report zones callbacks
> return an error, and in that case disk_update_zone_resources() is not called.
> So having this call as it is cover all cases.

I understand Bart's idea was more like below:

> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(str
uct gendisk *disk,
>       }
>
>   commit:
> -     return queue_limits_commit_update_frozen(q, &lim);
> +     ret = queue_limits_commit_update(q, &lim);
> +
> +unfreeze:

+       if (ret)
+               disk_free_zone_resources(disk);

> +     blk_mq_unfreeze_queue(q, memflags);
> +
> +     return ret;
>   }
>
>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,

And then in blk_revalidate_disk_zones() do this:

        if (ret > 0) {
                ret = disk_update_zone_resources(disk, &args);
        } else if (ret) {
                unsigned int memflags;

                pr_warn("%s: failed to revalidate zones\n", disk->disk_name);

               memflags = blk_mq_freeze_queue(q);
               disk_free_zone_resources(disk);
                blk_mq_unfreeze_queue(q, memflags);
        }

The question remains if this looks better?

> --
> Damien Le Moal
> Western Digital Research
>

