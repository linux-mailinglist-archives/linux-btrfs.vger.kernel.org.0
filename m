Return-Path: <linux-btrfs+bounces-17256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A8BA8E21
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2FD3B005C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF02FB997;
	Mon, 29 Sep 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKI2ot+G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E925D1F7
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141491; cv=none; b=u3HnWIzRO9B9nLcNf+hQfPrDVw23thS76SVixCJX9Y8ZRhoVb4f8dUDwiCehGFFbwczWQWeukpU5I7iejQmCCSEmSy9Sw3qcs/2hRnHDVOhQAOiEXBSDC0BwRGAezF3ZttWPm5VrKjML8Gh01iJFBinqOjDc0JBKCqXjt17G638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141491; c=relaxed/simple;
	bh=sPk+emdmCO6rcjcDkLFRQQyOSDWXym+HOROYWo6O2eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=FgFt6VKJgslZOfIssFuU9COLOHHCJsRcnjNBUijvryCzrr2qiAuIUz3aWqW8noE8JJK0Dr6eANzp0V7MQP6oIPhz3dEeAIP8LDHLZGCre6NRgBjV0C820S7LsFLn1svmyaOQqFD+rCOkZ0iJfzNkwo3BgsqV0HSo5rHRl0jQ/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKI2ot+G; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33831629339so76979a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759141489; x=1759746289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjoAhNELSH83Orpe+UHK3Sd5RDJ+A4e3hUmeXwG9Vks=;
        b=cKI2ot+GTdrfcNkYtFdePGSlUgneMbcKd3J5yT34KnpU1qk572GbPffMf/NHsGEs66
         eKyu2WaotGZmZzlS1cqfM7lwDIDSEelJiceGZjGs9g3ie56eE5rn7p3tCFwSEYW7b9q0
         bSYqX91YYf5l1Ys4DfsHRKV7j01szHgGPJUyEV48JfWHzQKGbeEKkB168duD4Gy0jIoR
         j/Cm13eH7CFeTpRmXxsf1K7BP8kbr7OIScGGrYJfGorEeIWreol4hMZwCt9f87oE+JnA
         qEjapNfLmmhdqB6oytvMUeYU+zHbgYLMuNhR59peVXOYNMtgdgSdcPNzMKmla0nQTCy9
         l1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141489; x=1759746289;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjoAhNELSH83Orpe+UHK3Sd5RDJ+A4e3hUmeXwG9Vks=;
        b=lfQ4EUVX2ErKXDrAnG5MDDXYEAUYljf1vr35uxej5g2ngvKPpaKB0iPeHkCKWprbth
         AxplDxM2X4gVE2U2qfZMV00K/GsEoDLUBFSDzgiBOdaiq4+JBrAcgrRz3l0+IrHUzfLG
         HriKab0VOPoj9Ex+uoT84cNU60fOJYl4PQjlyc6/ntADlM254sU9jMRgtJ/oEaVFG08f
         7HSp1XYvl3RjAXkyr4/u5FpFD8Lu+zowrib6mXq/1ZXZAIkwUETpk1h7OinsPJ7Ym5hF
         OqOFT+8hleY1KqyE80Cr31WG07bnJQIK/W9ZRyjbKbUon7PypLER2ogy4NZRV1RGLUeE
         /2Jw==
X-Gm-Message-State: AOJu0Ywx4If90SwPnbNAtu8k3CWK/rDjY5lY58Dw4yI84hsyqGgtEcNK
	O4JlocvvtO/KAfftoi62c1ZImyuAv3mMPRBlqwrDVcazKYo2cbasll0M
X-Gm-Gg: ASbGncsyBG/5n1E0ZN7Ov2Q345Ih2GqLdmW5dBhWdVRNf/6zjw5Hktq2v8AGD68UcSK
	BE4thvZZUfHIhY+0twJ2m/IDGkNG5V/Vn9ZoWmH84SQkAxcAIPzKHfcroSJXgQbDTqRnZpDV+O4
	+vKY6aqa+mkWliCquKfIEHcjGBc6dBWzY4GLdWbGsBz6/0SEc9G5r93CAVpr6vKLjCkbeHiHwWh
	s+TvVUOEfRL1E5a5qKxO0S3O2PqH0etwz8BI9q/B3MmDkunArte8yhuYbYjPFWyWwNphUuzyaOL
	F7fZemT+aJjuuFP2pl+NqO08UYJ71Kvuuce6z2+5sOdzZ9VT1OMzT3OwgEYemSUEMejgrsa44/T
	WcH8H1CxqVqMPEL1IjDkbs9MK2WJse+FCQ1uBlBiqEwhqp2rL389DU27vOBI=
X-Google-Smtp-Source: AGHT+IFCVUvEU5Nt4FV85MsrgKswiHbbLkXbb6jOSmFIelKkCcxqli8gWu1Gmiaqa23ID2n4iu4jRA==
X-Received: by 2002:a17:90b:4c0e:b0:32e:685f:ccd5 with SMTP id 98e67ed59e1d1-3342a302671mr8710401a91.7.1759141488784;
        Mon, 29 Sep 2025 03:24:48 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be148e8sm16699693a91.16.2025.09.29.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:24:48 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
Date: Mon, 29 Sep 2025 18:24:43 +0800
Message-ID: <5926212.DvuYhMxLoT@saltykitkat>
In-Reply-To:
 <CAL3q7H5OvZrFZDzhds98vwLNXO1ttWjJVajCwQRhPHmt+dDJCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> > -       ret = tree_mod_log_insert(eb->fs_info, tm);
> > -out_unlock:
> > +       /* Deal with allocation error. */
> 
> This is a useless comment... The existing comment is much more helpful
> and the fact that's in the else statement above, makes it easier to
> grok.

I agree that the existing comment is much more helpful, while I personally 
don't like the else branch appears after a return/goto/continue/break 
statement. So I think it's just about personal code style.

> I also wonder why you picked only this function, since this pattern is
> followed in several other functions...

Because I happened to read this, and it takes me minutes to realise what is 
happening and why it was written like this...
And I'm not sure how to make it better. Since this is the most simple one with 
this pattern, I just have a try to make it more clear IMO.

> Not a fan of the proposed change.
> 
> > +       if (tm)
> > +               ret = tree_mod_log_insert(eb->fs_info, tm);
> > +       else
> > +               ret = -ENOMEM;
> > +
> > 
> >         write_unlock(&eb->fs_info->tree_mod_log_lock);
> >         if (ret)
> >         
> >                 kfree(tm);
> > 
> > --
> > 2.51.0





