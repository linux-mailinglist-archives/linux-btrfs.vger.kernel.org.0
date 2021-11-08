Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D24449C3F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhKHTQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbhKHTQx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:16:53 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A80CC061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:14:09 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bm28so16492708qkb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agblB3E1WW2lcflREa5zzBztNrlqz5J91gemc9XQ/Iw=;
        b=eNZ1Tspvzdh3ggXeo5siZG2ZkHFJascbrvYrF9O9hXPcFlIjY1LtrXhwgXPLcPiyA+
         9dIumxFMpSRVEICwWBpRZTKIruu0Uudg7wgfW3wQzJwEPA5i70ng7dauUKGnH4ERPOp3
         tktWFDZEk2nxh4SbYId6qqsFa2AB+HBQ3xaTJyFNtvlSD8LgCXSHQhw1YYfWdZB1JY4m
         hFhjIrZ15w8u35HtaQAmlxRRv/LkV0cwrFqA7z+MR2Q+XrpGJw755EwaKM8c7dghk+Yt
         +YUvHZq466MuSwSlrklZCvyK2IzB8QD0bjwZ9hOwrJaRRXd1hTjLkrGcFpryFcD2fGn1
         S6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agblB3E1WW2lcflREa5zzBztNrlqz5J91gemc9XQ/Iw=;
        b=3E4apMU8byGkpOzb/i6FZBqw/ITqHRy6KP45HyR4o4ZHwiHBRMoLghTg1KtrSvsAzI
         xi6abdyKj72djC63SflmZ/NlujlDi/tIL3buzDA0JPxChSsoe4+N/SkbNl8pnWtPO9mm
         hSxymVNdKrDQ0X5aihH2lclPfXGXbIBMLlksYBVp3sA7PfBDfBTnOK3At9Tyhecma+LS
         paQhInuKrcJrn1j8NAwdqoAhMBJZLr3Oa1VD70o0CAEdTsnMIaVovpWUd7FSyf6ioDZ/
         N0Wn7/4vkpXasy0zsEvh6uTzridoXY2LFJjhEBZyAZoHbYRrXcIJ8UaF70jSpCaCEP6g
         fOUA==
X-Gm-Message-State: AOAM53191vs6FdNQ3aRcTwm2HwjAMQYfYEmuOgKAacrYHGtWNRwoe6jv
        GuPaYVNwSel8+WlpbJMCXfOkAXTyHtX6ZQ==
X-Google-Smtp-Source: ABdhPJyK4tcQ+zVul7V8jpLPHpmlZjbECHRBgrs4ElindgVBaXMYZovsREiPTKAixxocbFEkB3Yo1w==
X-Received: by 2002:a37:2c85:: with SMTP id s127mr1207518qkh.81.1636398848088;
        Mon, 08 Nov 2021 11:14:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11sm10857778qkp.46.2021.11.08.11.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:14:07 -0800 (PST)
Date:   Mon, 8 Nov 2021 14:14:06 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/20] btrfs-progs: mark reloc roots as used
Message-ID: <YYl2/prrZaLZPu1w@localhost.localdomain>
References: <cover.1636143924.git.josef@toxicpanda.com>
 <1da6c61af04c10b8a7e682676121e1031753fe69.1636143924.git.josef@toxicpanda.com>
 <1e61296d-58ba-b45f-a38b-b1da9e9962a8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e61296d-58ba-b45f-a38b-b1da9e9962a8@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 06, 2021 at 08:39:23AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/6 04:28, Josef Bacik wrote:
> > btrfs_mark_used_tree_blocks skips the reloc roots for some reason, which
> > causes problems because these blocks are in use, and we use this helper
> > to determine if the block accounting is correct with extent tree v2.
> 
> Any idea on why it's skipped in the first place?
> 

Yeah I added it apparently in

439ce45e ("Btrfs-progs: add --init-extent-tree to btrfsck")

because at the time we didn't deal with the reloc tree properly and I was trying
to unfuck a users file system.  I'm going to say that isn't the case anymore.
Thanks,

Josef
