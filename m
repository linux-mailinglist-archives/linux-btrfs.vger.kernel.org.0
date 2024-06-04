Return-Path: <linux-btrfs+bounces-5449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A08FB8E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C366B31936
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138914830E;
	Tue,  4 Jun 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EBwhrWeb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9D38396
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516982; cv=none; b=MkPjUhBZVO2qewRSd85woqQHTvyDCfUsusuu7Ih/0CRcRjLT6juvDg+ncqywYA3R4nao6oie07kXZFZj6IJ7kG8MvcI7hqVi49m3qK1G6ZZ22pBSu+foZGCfrYdGOnv5Z0Zx5ogtVWDX/fpIx+sDmWcGGzBmRoVkpJEJW972UjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516982; c=relaxed/simple;
	bh=e4w+nsnn/wvl4b18G/+J5ixmaOqVIhCZvYX3O3voMSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg4ZGkY0ddpCHVJvKLB2kurxyi9qz18gbTjBtdAtnTSIjVH5vAygcXruHtq5GMpPxb/9z0Ubz4teSJdxokBgQeC+fY9eeMY5AoATvmLXFcjMEYXzExGqO1EywPNo9QbzWzN6QLbQjTgbfMXtLs+P51FBpyZPjuRt0AiKdKG1rJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EBwhrWeb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c21574d8ddso2359684a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717516980; x=1718121780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EU/51INeNCu5ow1qMb/33iVM9tIIl0kmBT3/55WRMI=;
        b=EBwhrWebNpaG6C6o1jMYQEK1+FBX3+WAPgTqYCznlWipZDjtiiI2Y1CExsA3GwS0R/
         gBJoH5Ax3R2tZVw9/1/ko+8EzgOb8a51SrshhVpVcu5JBlU8kyr8AiGpyPjekisuUwKQ
         EMAAhYNRnZLS/6wWOZ29RKJCWdm/4zgJ4SEoNj0/CHZZ528/OKXDG1MDadO3UL6Xknt3
         7tjrDWV2vcLRhrOh4S1cZgGkbORwB68y3plXx8yEq0n7xfDywudJofjF4sjyFuaFb4kC
         TEHoT10BD9OSljFuDRGnQaOBlLYtv39/EMmyQYQF64QfeF7KgoMkUBtuVePQgdWG2zNG
         Cv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516980; x=1718121780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EU/51INeNCu5ow1qMb/33iVM9tIIl0kmBT3/55WRMI=;
        b=R1qbdLU162DV65kvKD0hGYIM0gBTjsnowY3NC2iIkPXhMmKTubwB4rCzRThzJPIS/r
         WX9AtOqqFUIyilQJDXLqCnu7lmpMajU6ceWWtu/Rhw72NAX/AK48wPE4W6N0lVPwPiOS
         mZeW2B/Nx9KGz74YNYi9nhT0xOE8F7G2vACi/AD1qylMNVkMh36OVgrqXe9Jpzqr0abD
         CHJUvaIGYxBLUHLAwPL7WrHmmUNZJ19eqnWEPwFZqs/KRqguQom5MFW3hLAzvuQReStE
         mCtVkiL/QvERcTVBZBJvFVbmZpPaffg7R92paGg8GqeFhwXHCrq5ivviDTzEGxgJJ0ze
         WVdA==
X-Gm-Message-State: AOJu0YxPpE3PdYz4Hxg55IaxFD+W5B7wNXYiwsX7PmtBva+V2M3tttpW
	aIZs5GsJYHIrV4ZbmKLQngeVdX+x59CcSZ5TfYQWsM7d7RXA9E1Wqttps7JywmypnAA4XwKUa/6
	M
X-Google-Smtp-Source: AGHT+IF1NpjaRNN1MQ8nV6ayBI3rDC3r4ftj++toT9gjH5Odden034akATuiyrosuCjso3tNKl1NJA==
X-Received: by 2002:a17:90a:3d46:b0:2c1:b99e:6fd7 with SMTP id 98e67ed59e1d1-2c1dc56d9f6mr10312934a91.2.1717516980235;
        Tue, 04 Jun 2024 09:03:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:5165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2559e6741sm1314716a91.1.2024.06.04.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:02:59 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:02:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: some tweaks and cleanups around ordered
 extents
Message-ID: <20240604160258.GE3413@localhost.localdomain>
References: <cover.1717495660.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717495660.git.fdmanana@suse.com>

On Tue, Jun 04, 2024 at 12:08:46PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the individual change logs.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

