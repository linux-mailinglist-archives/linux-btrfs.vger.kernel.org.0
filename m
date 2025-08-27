Return-Path: <linux-btrfs+bounces-16444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D06B38581
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5235316B0E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB921A95D;
	Wed, 27 Aug 2025 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="fnZpwSlC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADD2153E1
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306494; cv=none; b=ldkgplgAD74k88liFlKmsWrv9zt/msSN1V1rUhOpWpc0IpxoFGKoQkUK58Zs48RX6jagy1KiVHWKusTmOMfsJaQ71jY79cxEzQ5SbXQFnexNQ4T2KPm/1FsoHiGTaOWhflIDSuK8c0Y6XTOtZ2kFAzlSz0GqNohKJeqitkXqH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306494; c=relaxed/simple;
	bh=p7Femr3MH0SjlXMwhy+YuUVugyvqfq1RJmpvLJsYpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neQT0ffXJpVOIL8xcIZeWrcNZh4VWcRDzMmqyFGQghrSYoKRe8ARMslJ1magKm0eY0Opz6t+OVnzjkZbzIKu0IpFemqIM4E5xUF6Ou2JfV3kQ5TZLYuMgEyl3pYiiSLtR2+pSNxPuw+HcyRj1TFMfDBw0tV2i3xFkktJaOOfsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=fnZpwSlC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71ff2b20039so41005797b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756306492; x=1756911292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OCXs+jnWwR7FWJtHtpNrO1FLD08aYIad5UriCvf31Q=;
        b=fnZpwSlCLZ9PWU/SwK+byze1YdaEjmQGQtmBVyUZLNRlAEm08z4lIROxcXYrzsosZW
         dQBg5mhmO5MTC4lXYPxZ60i1kxfbIERRShJ2aelqNSBhfApBTaxdPEG11BYLezh7fJD2
         WRnIp6jQwTa4IDKz7HNPjPvAKoyHEgSRq4BHFDYRvYpwk4T2aP08eRmRK0cHBxzHWpEv
         iP4n0KrmWC8QRaQ+L1KjpBDROqty9cNA3k/KnBA8sUiGka7ggcODA5MnFGsPIA6s1ysv
         +A+qCPFZ6id0H466NBDtByHYcUjn3FUTs/VLSfk/m/LP6yBMBsyC+Fw46SMuVvouIyz7
         MyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306492; x=1756911292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OCXs+jnWwR7FWJtHtpNrO1FLD08aYIad5UriCvf31Q=;
        b=APIUSwNkyJbYL6MBTMb5qAAfVJOb0fs5K+M7qsruk1uwsfISYSKJKCAYnRJQUFzW9U
         HWaa9y+xSsXxxX/hAhrwUp9UMvdBG2knkauPh5JTQxYMUI7gC3YZv7XkaYIlbakJEhlk
         RPyDnA5wv5939KeRZhlebWxAXimnhwYlXL25MYvfdoqPPa+3Icgr0hVP2wEWZMj6s38d
         mvrHvbkubKJCJLuQCq+9+deWlBQVIhsQ3DhcbUjz50uU7J9blMWKzJwBojh9sN+EmRiP
         UtTwK6w9x2RocSZFcEoS6SnUzA/t0dmbA7cwzD7XN7ZDiYKjuNcRowI9ShDT/qmEdc1i
         FxsA==
X-Forwarded-Encrypted: i=1; AJvYcCXQOFXUO7PM0Est1xAxE/Z1aPO4/+8QocfxLqONLE4DlbneDKQ9egAFKq1+96cbH5iII4tvPnVNMrGpPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtdha/6U1D1qoqSWsNw/F+1JWysnFee+0ellO6YP0dCginhvz
	7A41MASRMibc4fCiIEeiAtUtMlVFcJi2WuG88CIvk/ViYeXvvsq9zfkKqcCK7W3u89Q=
X-Gm-Gg: ASbGnctn97sp/l9psgVpsxVg/Eyhko6mJAjTS676PJDjCigrhfjppnbv208AVdCaO1Z
	Z/19jM4ERFiH+4zfHvNMqMgY7mBV2gN3icvVBTjjjIueor4X/EZERkjNQNAzBIjmTjF2nzZLfE/
	PQ0bEb4Tyl9R/IwkdgJSNw8TMGUc0mNMIrGKcJO4HICwVkg+ZYNmxqmYXEEl4bSPnarD40mOjIT
	KnR/baoJyE8c++CM6MVuPuR7HoK/HleggMvxMUu4YSQcGPPIrDxAysA9cNcxVuoIs8AUtnby7iI
	btFENZy6adm6knF+SEZyppKlEVADcKfsmxQEU//J5ear5Iuh7NbCHTcfFp6V8n0leaCMDeTkw4L
	UlcAi59WdHlg9NhEypHOyeGRAay/FxpqQMfPWNldALTzY69EvVGyJYniK0rsDWZmPpAkjNQ==
X-Google-Smtp-Source: AGHT+IFyYOwHMJoEXmOQ8uGAH/l+ZKAO0DrXblFReatS3WwuC7vhpTGGm7wAutkG59wh9SZ1OWY6PQ==
X-Received: by 2002:a05:690c:6805:b0:71f:95ce:ac82 with SMTP id 00721157ae682-71fdc2a89e0mr220525927b3.9.1756306491322;
        Wed, 27 Aug 2025 07:54:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72151e8f522sm1970907b3.3.2025.08.27.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:54:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:54:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 03/54] fs: rework iput logic
Message-ID: <20250827145449.GA2271493@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <be208b89bdb650202e712ce2bcfc407ac7044c7a.1756222464.git.josef@toxicpanda.com>
 <rrgn345nemz5xeatbrsggnybqech74ogub47d6au45mrmgch4d@jqzorhulkvre>
 <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n6z2jkdgmgm2xfxc7y3a2a7psnkeboziffkt6bjoggrff4dlxe@vpsyl3ky6w6v>

On Wed, Aug 27, 2025 at 04:18:55PM +0200, Mateusz Guzik wrote:
> On Wed, Aug 27, 2025 at 02:58:51PM +0200, Mateusz Guzik wrote:
> > On Tue, Aug 26, 2025 at 11:39:03AM -0400, Josef Bacik wrote:
> > > Currently, if we are the last iput, and we have the I_DIRTY_TIME bit
> > > set, we will grab a reference on the inode again and then mark it dirty
> > > and then redo the put.  This is to make sure we delay the time update
> > > for as long as possible.
> > > 
> > > We can rework this logic to simply dec i_count if it is not 1, and if it
> > > is do the time update while still holding the i_count reference.
> > > 
> > > Then we can replace the atomic_dec_and_lock with locking the ->i_lock
> > > and doing atomic_dec_and_test, since we did the atomic_add_unless above.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > >  fs/inode.c | 23 ++++++++++++++---------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index a3673e1ed157..13e80b434323 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -1911,16 +1911,21 @@ void iput(struct inode *inode)
> > >  	if (!inode)
> > >  		return;
> > >  	BUG_ON(inode->i_state & I_CLEAR);
> > > -retry:
> > > -	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> > > -		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > -			atomic_inc(&inode->i_count);
> > > -			spin_unlock(&inode->i_lock);
> > > -			trace_writeback_lazytime_iput(inode);
> > > -			mark_inode_dirty_sync(inode);
> > > -			goto retry;
> > > -		}
> > > +
> > > +	if (atomic_add_unless(&inode->i_count, -1, 1))
> > > +		return;
> > > +
> > > +	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > > +		trace_writeback_lazytime_iput(inode);
> > > +		mark_inode_dirty_sync(inode);
> > > +	}
> > > +
> > > +	spin_lock(&inode->i_lock);
> > > +	if (atomic_dec_and_test(&inode->i_count)) {
> > > +		/* iput_final() drops i_lock */
> > >  		iput_final(inode);
> > > +	} else {
> > > +		spin_unlock(&inode->i_lock);
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL(iput);
> > > -- 
> > > 2.49.0
> > > 
> > 
> > This changes semantics though.
> > 
> > In the stock kernel the I_DIRTY_TIME business is guaranteed to be sorted
> > out before the call to iput_final().
> > 
> > In principle the flag may reappear after mark_inode_dirty_sync() returns
> > and before the retried atomic_dec_and_lock succeeds, in which case it
> > will get cleared again.
> > 
> > With your change the flag is only handled once and should it reappear
> > before you take the ->i_lock, it will stay there.
> > 
> > I agree the stock handling is pretty crap though.
> > 
> > Your change should test the flag again after taking the spin lock but
> > before messing with the refcount and if need be unlock + retry.
> > 
> > I would not hurt to assert in iput_final that the spin lock held and
> > that this flag is not set.
> > 
> > Here is my diff to your diff to illustrate + a cosmetic change, not even
> > compile-tested:
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 421e248b690f..a9ae0c790b5d 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1911,7 +1911,7 @@ void iput(struct inode *inode)
> >  	if (!inode)
> >  		return;
> >  	BUG_ON(inode->i_state & I_CLEAR);
> > -
> > +retry:
> >  	if (atomic_add_unless(&inode->i_count, -1, 1))
> >  		return;
> >  
> > @@ -1921,12 +1921,19 @@ void iput(struct inode *inode)
> >  	}
> >  
> >  	spin_lock(&inode->i_lock);
> > +
> > +	if (inode->i_count == 1 && inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> > +		spin_unlock(&inode->i_lock);
> > +		goto retry;
> > +	}
> > +
> >  	if (atomic_dec_and_test(&inode->i_count)) {
> > -		/* iput_final() drops i_lock */
> > -		iput_final(inode);
> > -	} else {
> >  		spin_unlock(&inode->i_lock);
> > +		return;
> >  	}
> > +
> > +	/* iput_final() drops i_lock */
> > +	iput_final(inode);
> >  }
> >  EXPORT_SYMBOL(iput);
> >  
> 
> Sorry for spam, but the more I look at this the more fucky the entire
> ordeal appears to me.
> 
> Before I get to the crux, as a side note I did a quick check if atomics
> for i_count make any sense to begin with and I think they do, here is a
> sample output from a friend tracing the ref value on iput:
> 
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_count.counter] = count(); }'
> 
> @[5]: 66
> @[4]: 4625
> @[3]: 11086
> @[2]: 30937
> @[1]: 151785
> 
> ... so plenty of non-last refs after all.
> 
> I completely agree the mandatory ref trip to handle I_DIRTY_TIME is lame
> and needs to be addressed.
> 
> But I'm uneasy about maintaining the invariant that iput_final() does
> not see the flag if i_nlink != 0 and my proposal as pasted is dodgy af
> on this front.
> 
> While here some nits:
> 1. it makes sense to try mere atomics just in case someone else messed
> with the count between handling of the dirty flag and taking the spin lock
> 2. according to my quick test with bpftrace the I_DIRTY_TIME flag is
> seen way less frequently than i_nlink != 0, so it makes sense to swap
> the order in which they are checked. Interested parties can try it out
> with:
> bpftrace -e 'kprobe:iput /arg0 != 0/ { @[((struct inode *)arg0)->i_nlink != 0, ((struct inode *)arg0)->i_state & (1 << 11)] = count(); }'
> 3. touch up the iput_final() unlock comment
> 
> All that said, how about something like the thing below as the final
> routine building off of your change. I can't submit a proper patch and
> can't even compile-test. I don't need any credit should this get
> grabbed.

Thanks for this Mateusz, you're right I completely changed the logic by not
doing this under the i_lock.  This update looks reasonable to me, thank you for
the analysis and review!

Josef

