Return-Path: <linux-btrfs+bounces-10167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EF9E980D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 15:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36171885EA5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829335955;
	Mon,  9 Dec 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GRRts+U3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DA233148
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752909; cv=none; b=QJMqNfwPcMnKJYE14Fj0wVBNbOattebksh/GkGrR644hOXDJjSSuvPwJFqAoKKTPTwzTFrScMnSKT/SOyoaKI8PW5iNWeIiPuKyJeprEiRvNHZe/dLlOb35x7ik0MyOD8dsspbDo2lvR81y739nbwkxZn7vQR/EnoXXNoNjEJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752909; c=relaxed/simple;
	bh=EHFeKiQ/slM3qQWMA4lk7lf4+W6ferm8HlHdnpfcolM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUCav0FmWGInw7UYTfgQYNSrpxDDF5cmnEy9bVkk6AIUbr6rPA4RhHeT/2o1VMOP8sfhFkMRsh2mCPhiONv7QWdHUyeP3kf3uyqbn6os8qzxvYaMO+XkB61Gb6z+j5mhmXy0IHFmDM3VwWduY9qkBAnPiJutcE+xTbKrLYXfu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GRRts+U3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46772a0f85bso927521cf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733752907; x=1734357707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBdaq3O+e4Va/VfcTygBgPJmUQi+DacF59ODyqUvNyU=;
        b=GRRts+U3GpstNCtwHAV6MfbWZGpK/yQpj62h1tzYsv/KdWHUspGnnj0EuveqaM2TtN
         8BSh/iKKGwMSoBWbGm8KuZuw8mzzhhoeg5+/CFqorrC/ChDO4d37FA48PwwBGEN6tSEY
         mzGUoyXMplDS4XNbEoD3Zg4O/ddRKNciNxVGngjOPZHmmqr0rF2Sq3ShRxj5/aNzGctb
         J3exm1ROyZt2MiDJa/p2rRMUkjQQANsqUoPcxeEJ4VcgdWXt5YOjZHXHRrcW3XQAU36I
         2pbx6tKOcskHAIZp+WoI9lIwN4tRE6jy/5lfqIzkRVA9Ba14f1LdA1oWXKxoZ0w/8IEY
         nDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752907; x=1734357707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBdaq3O+e4Va/VfcTygBgPJmUQi+DacF59ODyqUvNyU=;
        b=EdT6twMYvRUxYTvpoZ5efAtd+fY1doiJNynWK9p84GW2lp8vg2YSpe8V0/zurbLGE3
         YGwcWnNZIW8P6dijg/bufn8yUGvsBus4s+1IdajRo5V/Ju+L6VyKTPL4j49uBuPCAZrT
         G/n1PvOx2Fkov2wcRoaLbMKSC8SBlVECulcGqILBQTrwP4l7wEYjkq2Sf2YxA3Ij41uT
         bjF3Xyxyca2vcO0PJWTFPT+5T9iTwBKCi8s8HcaZFTwsP1B1Y06fPBHDQPC9ZkXsLnm9
         ej9vvQjEYxFVJyywM+UuDMCKDgpHnNAucawL6V6puh7izCpJkwl2rcpMKBFL5ZqhUhzN
         yD8Q==
X-Gm-Message-State: AOJu0YxXRcATkgkurqkCjGhXdXkSUUyy7+M9w368U3zvwQi7sX4N48cy
	5zdkDM5eDFOBE3jUZZm6AsBbtfojuvK1JKLcJxROsSZwqOuWA/+frupMv+Oj7Fo=
X-Gm-Gg: ASbGncvkAC5SIitokgtXFPLZG8o8V83H2c94qbLSTX/wLYgASRK/GYG5qAQ486GwA67
	InK0Rw6o4SgGylEVIE15bbm9f6elwV0VtoMCPaW+29cQrZnOt9G8M/mjEOcLwxDgCxP53k3h0al
	caKyrdUAMyg1kgNZWsnT04vZGSeKS6mrcrtqtH8b71zkVQulEUM2/nhLjgpqJ27OgHufUgVT2Fp
	sE4gZ0r3ymHp7ZTSlqjmcpCF+NyUDm2kIB3ER6ynlqm9CDJerbKk07V0II+tdrx30pCjm4OQQ46
	7opP0wPt5nc=
X-Google-Smtp-Source: AGHT+IF839k0+NoKwZ0ewbKx7tCN0PV7dbQ/gHnwyORYJRzA9GcZ2DOjTtqojYLMKZkDMVbLZAcQ9w==
X-Received: by 2002:ac8:5d03:0:b0:467:5da6:8096 with SMTP id d75a77b69052e-4675da76ab0mr68104271cf.44.1733752906524;
        Mon, 09 Dec 2024 06:01:46 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467297c23b7sm51463041cf.74.2024.12.09.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:01:45 -0800 (PST)
Date: Mon, 9 Dec 2024 09:01:44 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: add delayed ref self tests
Message-ID: <20241209140144.GC2840216@perftesting>
References: <cover.1731614132.git.josef@toxicpanda.com>
 <78564483832375111f2d9541678cffa5d3c0c30a.1731614132.git.josef@toxicpanda.com>
 <20241115183305.GW31418@twin.jikos.cz>
 <20241206195100.GM31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206195100.GM31418@twin.jikos.cz>

On Fri, Dec 06, 2024 at 08:51:00PM +0100, David Sterba wrote:
> On Fri, Nov 15, 2024 at 07:33:05PM +0100, David Sterba wrote:
> > On Thu, Nov 14, 2024 at 02:57:49PM -0500, Josef Bacik wrote:
> > > +	node_check.root = FAKE_ROOT_OBJECTID;
> > > +	if (validate_ref_node(node, &node_check)) {
> > > +		test_err("node check failed");
> > > +		goto out;
> > > +	}
> > > +	delete_delayed_ref_node(head, node);
> > > +	ret = 0;
> > > +out:
> > > +	if (head)
> > > +		btrfs_unselect_ref_head(delayed_refs, head);
> > > +	btrfs_destroy_delayed_refs(trans->transaction);
> > > +	return ret;
> > > +}
> > > +
> > > +int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
> > > +{
> > > +	struct btrfs_transaction transaction;
> > > +	struct btrfs_trans_handle trans;
> > 
> > Build complains
> > 
> >   CC [M]  fs/btrfs/tests/delayed-refs-tests.o
> > fs/btrfs/tests/delayed-refs-tests.c: In function ‘btrfs_test_delayed_refs’:
> > fs/btrfs/tests/delayed-refs-tests.c:1012:1: warning: the frame size of 2056 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > 
> > Please change that to kmalloc so we don't get warning reports on configs that
> > bloat data structures. On release config the sizes are like 480 + 168, which is ok.
> 
> Fixed in for-next.

Aaaand you're cleaning up all my messes, thanks for this,

Josef

