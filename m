Return-Path: <linux-btrfs+bounces-3438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEC880411
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB6CB2376A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFF23772;
	Tue, 19 Mar 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Wo4Tw9a3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604F286AC
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871092; cv=none; b=sWwWwKT+cWzhQqVPfCtctsSZxD8n9MfYcm/sM7QyVm+GWprKRnOgSaChqpwxXnDuUOZQ7XyyaSqkvA/rQ6SDG2TEf56I0iJ0pO9QfKAJJgt/Y6U3qqc1xPX9HLt3PZGlHn6n9eBiK7x30Le7PegDWuYI2R6RO4yRmZD80yJUyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871092; c=relaxed/simple;
	bh=y7ZA6HXQQ+6l5w97RiCOppwlhSlMPyKk6eIblkqEzYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm92MV38N0yqhenqidHdbqSFbQvkdEruCB7/PyK81eItmjlqErHBRV5k9kts+jdujSBg9zab8ULFLKoqzz/g9CEBAw98sBev1wuYN9UfuP7bF6AUJ7ZevKOH6hFdrhPsD4n5jznvqp35FmCiVlzLJHnCYcwPeFUnZwGt1z7lZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Wo4Tw9a3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-783045e88a6so418140785a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710871090; x=1711475890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYOzv7AGl+fIw1t/BoXnxGEIEds+dr96NmrS2rWW9z4=;
        b=Wo4Tw9a3ogdfMPdpW/QGE7aryi98bLZhTxS6wn+lLj4+1v/J1JowOPwphSuFPUD/qk
         BRho6qxoyZYIOhum0ElIUC1vmRaorJpYSETGPBqJwxUlAH3SPv9Hmpby7bRUS8Ziarin
         TAoJglmZNiLLaudfrFAQLh3sEVpr9lcPuDNK4grUXq9Fkw0vP5lg4BEhMqTZnCTqTciJ
         WefIP8zn464zAnZn2/Pz5yT3OgYJUJV/zcYk9O5KcXyopjn+MFc+3wl8557/gBenq0C0
         DXG/amnjI0pOoCwMB2xSPFzEkgmVo6Wyw2EPPojT74tMMMUqaLiilbo3L5FsLglAgFpv
         QWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871090; x=1711475890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYOzv7AGl+fIw1t/BoXnxGEIEds+dr96NmrS2rWW9z4=;
        b=dY1tcXjDobWsu3ThpLfoK9x54OiNXJzWbW6G0BJbV8m/oicqaZUURH+zGVTWQbJuPB
         mzyORfRH2bnZwB4IwaaXtQt2GzjCPvQTvUaLOs9DqcdtWYfNjtCLO8CyXCvnMQSuQdw1
         hwMrgjg59hA1R0lKD3j5/SFfKzvy4xBxN/BYf33rUaR7dTRF/ubGdJL4Rk6nuq1RkWHW
         Ihm3m1tGZXbj95RjXx+unzN6CkFXfTbqfr5ykeWYBtm5r1jfTOiZlKRr/OxPZq+p42hA
         qSTZx40AXn+QE7yCCpPbOSYxYUYASVgpZ7UQGOI2t0dfTRe0xP+Dype4IE2kGITMJpB/
         wZiA==
X-Gm-Message-State: AOJu0Yx5N5wS2g5rDUqfg7s7uZ0tg91+7FLu7UJ4U6aCI1DDEyihrnMG
	+gMPenMsk/yktAT3SHY1oMIVa9abLzVPK08gR9J2kYM0dkzLRT8G0c3sVhSDwBw=
X-Google-Smtp-Source: AGHT+IGjgzUglhOAIONokcsyYN3Z7bOGJkd60khxsC//uITEX2uVgT0HJfhGHEQW25dk6/ZAGpDpnQ==
X-Received: by 2002:a05:620a:2913:b0:788:7c9b:e5c6 with SMTP id m19-20020a05620a291300b007887c9be5c6mr14781547qkp.57.1710871089767;
        Tue, 19 Mar 2024 10:58:09 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a0b9200b00789fe83b050sm2255026qkh.78.2024.03.19.10.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:58:09 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:58:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/29] btrfs: relocate_tree_blocks rename ret to ret2 and
 err to ret
Message-ID: <20240319175808.GF2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <4fb96310be2a8a28757ee55042321749bc6d1e69.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb96310be2a8a28757ee55042321749bc6d1e69.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:23PM +0530, Anand Jain wrote:
> Coding style fixes the function relocate_tree_blocks().
> After the fix, ret is the return value variable, and ret2 is the
> function's local interim return variable.
> 

Same comment here, we only need one ret value.  Thanks,

Josef

