Return-Path: <linux-btrfs+bounces-18896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AABC5392C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00091342200
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBB32AAA7;
	Wed, 12 Nov 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhRQwzuO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B431AF24
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967048; cv=none; b=KwB3a0/N8cgek1wbo9hVTloEU/o0iS11FIjVKraij06qR0LQvFswz0SXwgkruDhckuEwJmWKjrK7UBwPiNjoz9tPctbFfjE5Zf8hOJ2NwF4QfEB9QMcUvWkZnRyJ9ar3ZtD3FS4G2UJy6J1zvXrYx2Z/EIsM9cxq6daV5Op1hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967048; c=relaxed/simple;
	bh=YNUnUW29WGgYvHmssLOQzNGAga3ZwdB49ndEqbB3IG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxb0G4kl0AjVtKbtdSC6ZboWlzHfJwdGV1Cuc6qaBY4jwB1PvvuWi4wFJOhD5aGwn2YgD24DGppN6Ytss93/rOif7ite+gyqN5TfmJ3GmDtU/wP50cDRNKR344SVoo+nsNJiwDuAiFKMMeZbEZ3q2LOttmsONqwyH3ApYU2iMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhRQwzuO; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-640d790d444so1004617d50.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 09:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762967044; x=1763571844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1MAVS+duT+CCEX1s12T8DfNLnYBmUE5WD8ayuuzgwQ=;
        b=dhRQwzuOvkfB/LPoh4kBARUJ4WfAjeS5QZcrjPkQdg86/ijnoDgXFUzaWB5FlXUQHC
         ogyTj61etAbGvlxxL/7M6IWyp0Mu8C0Eg//DJpWJ82QOYs3+Zq/iaG6+Wb1tHOhDiI1t
         G29M/xXO2rACzqlHQfmrm2y37zI8R6HaxR63z0iEe6I96QwWpuSvjVCPKbLMwHIVsTEa
         q/4+F101ELjV4dGm4bMoexVllfRmMqsG3i5VPj1x1YyIUW/v8FTyjyYyfifxR/ObQM2b
         aqbauqKQz6bJDNdsqYd8azcsZ/uCzcf86vK11MVzzCsLD13PxMyhIZY2XLe1lMay3Uf+
         gdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967044; x=1763571844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1MAVS+duT+CCEX1s12T8DfNLnYBmUE5WD8ayuuzgwQ=;
        b=tm4HBYJiWb8ZYIsEeAjH+oiNwbHpKRhGUHd1QFls3l5ex0Yxq4AYSK8hHB10RaUU/X
         m5rgAEy0K/WffYDXAo6+8VmBlpIyOCL86YJU9dEcyL4iCMmhQW+1NkT1w7KjXrAj/nZM
         2AjquTdfk3JcdzXvHa8d/3FwHLNOTbssmXgrnlO1bxs6tY/b7EbbHibSPXGMCmAH3Re8
         Yuk86G1xcKzL65JR7UQCzhwWy16dD4ETstIYAM6Xdlq+Y6nQbIkxqzb19VVki7vP2A1B
         n4GOAPkR9LIv6UXaSb0f4IBWUJgScjw/1EWDyfSFukjHOKVavk6VD7DkCoRwpz0gQu4Y
         wNng==
X-Gm-Message-State: AOJu0YzytvC/Rh8Mu1MaGWG61ny02eRaQIME3RlSanrKYnt48nepCpMj
	2jQXl9YgdwJSR59ZZ+yVTEXs9UMLUN93Z38lMNvoIbPO4UlbWCIjV0hI
X-Gm-Gg: ASbGncvjZG7AEu5N7Ez8Z/cuD1gEz1jGOeokN4X2j/ieKQE+iI9orH6dv+0gEuQDaIH
	wOZk0AsZ6s3hjeMJV8NX3C3XdS1tKsIpX0CxkAl5X81lh3JmGonOzTcy8Rh+4uzuJHIQzcgd75E
	e7L0mE3+1CyOBtrFfSyK3WPf5DVrmGxzbzmqF8RH5uuJKUanC6qClh14+5HkkUYH0LzWUvw5Oeo
	9C14+ZyXQ+NFRc96GZEW2kQ2RG2aWMe1Im3PUcZuPxne8xuHzpJ4DaXqN0DXUbLWZbfINO0fKNx
	b+0KseHFqJ+Q2MxlQSuvcrGfrl2aU7d68GIYA9Qj8iuu3kJqa9miJ2Yk7YsyoDikQ26TvGd3yBR
	emLkXzN9qz6n813xHojJ50J7KjU7Z5s0LTeH3EPpAWZkklLY3AoXIgKIN62f8RjQ3Zz/O0EjePt
	YOrf6QQ/hf2ttypttr
X-Google-Smtp-Source: AGHT+IE/+eOAZNdtvR+xXa7y7J0mZGHVXzJ7M2lvoTIc3BQr4guICQkg/QVcLcDNPNVP5eLmyC2Ljg==
X-Received: by 2002:a05:690e:781:b0:63f:b605:b7eb with SMTP id 956f58d0204a3-64101b8216cmr2322183d50.67.1762967044517;
        Wed, 12 Nov 2025 09:04:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-641015c3dfbsm1102152d50.7.2025.11.12.09.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:04:04 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: take delayed_node mutex when releasing item
Date: Wed, 12 Nov 2025 09:03:55 -0800
Message-ID: <20251112170401.506658-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112070925.GD13846@twin.jikos.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 08:09:25 +0100 David Sterba <dsterba@suse.cz> wrote:

> On Tue, Nov 11, 2025 at 04:22:57PM -0800, Leo Martins wrote:
> > The error path in btrfs_delete_delayed_dir_index does not take
> > the delayed_node mutex when releasing delayed item.
> > btrfs_release_delayed_item -> __btrfs_remove_delayed_item which
> > has lockdep_assert_held(&delayed_node->mutex)
> > 
> > Fix this by taking the mutex when releasing.
> > 
> > Fixes: 933c22a7512c ("btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()")
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/delayed-inode.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index e77a597580c5..30dd067e2db3 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1662,7 +1662,9 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
> >  		btrfs_err(trans->fs_info,
> >  "metadata reservation failed for delayed dir item deletion, index: %llu, root: %llu, inode: %llu, error: %d",
> >  			  index, btrfs_root_id(node->root), node->inode_id, ret);
> > +		mutex_lock(&node->mutex);
> >  		btrfs_release_delayed_item(item);
> > +		mutex_unlock(&node->mutex);
> 
> I don't think it's needed, the item has been just allocated but not yet
> added to the rbtree (__btrfs_add_delayed_item() a few lines below).
> 
> In btrfs_release_delayed_item() there's a check if the item is in the
> rbtree, if not then nothing is done. Otherwise the lockdep assertion is
> checked, and the locking would be needed.

Whoops, you're right, good catch.

