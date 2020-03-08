Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5117D458
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2020 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHPPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Mar 2020 11:15:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42475 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHPPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Mar 2020 11:15:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so694460plz.9;
        Sun, 08 Mar 2020 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=maCjuDBFJNKb7LdpyvBOBBIGZTJwea/aVizT18JDPKs=;
        b=bvLhsc3ZPXkpGKQ58mQBJ3M6iVLylL8b2NZz0V5StMF1T//ZLKjfWOr4SNfOqujL1u
         vDoYkoe5LB/Vl6Mo1ef+IVj2+dk7/bD+UtjusiO49kUbgIjP9H043lIogBdewSf/0jAv
         HhSSpwPXyHUNBT0B4tPFFhO3lhyUzm/67QF57wq1/YhJNqc8m2Ydxi6fio1bBAnDNvbJ
         GeIPLtdnY+fBj0NfBesVhWwpTI88t70upoyBTNNij7ubWaHvW1+V6xU+zAeNNM6Po0yW
         7793vsxLTM4Q6nX3xpCSy9QS/Lp0CRJnAlK1WOxzvVupRHxC+6KU0wtu+z2AtGu5RvGJ
         sf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=maCjuDBFJNKb7LdpyvBOBBIGZTJwea/aVizT18JDPKs=;
        b=Gnh0/7YH7qsp2ZhqmS9mttNl57NrrEqKY/IBetm3nEHslJG8Ip5qWdD0DRpA4UPjfo
         1+i3aQ0kXPSs1WFspm4OknKzqGRqyEgwWvMOd1AqcwtrOgOjP+rHXhtmn4Eezg9jGIQQ
         XVx6FM0xz8F+zsKl9qY0h7FHP6HiRdThCnWNb6ypPzegmhMPwO4C4zF0HlnB+5NIdoS9
         i7+6BjvDWcblsdzUMrIp48aQoQsUhMm5OHXXmOvK5vQDKivVZjAb/3Oo4SZcvbiWbQX6
         jy0iQW6AsleM/vNxfyKVTR2xuB9Oph+2oBXJv7wVM51GZvCV9SdUpzm+BuLwEPxcTW6a
         dk9g==
X-Gm-Message-State: ANhLgQ2bC28goQQvvpMEsZWGGvc/+v//p4NsDj2qlt87gYhBhZD1fi73
        UCM1dC0NjsWKw1BkRXSUavw=
X-Google-Smtp-Source: ADFU+vuzVJQZYo3c8+oK/T6IkHTHQ4CmGHDmAT2jKpGRFc6SpxV+Zh5mmDTmeOIcXXeeqPdmabNzmQ==
X-Received: by 2002:a17:902:b10b:: with SMTP id q11mr11776932plr.49.1583680520135;
        Sun, 08 Mar 2020 08:15:20 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id u12sm41784934pgr.3.2020.03.08.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 08:15:19 -0700 (PDT)
Date:   Sun, 8 Mar 2020 23:15:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 2/2] btrfs: Test subvolume delete --subvolid
 feature
Message-ID: <20200308151446.GE3128153@desktop>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-3-marcos@mpdesouza.com>
 <20200301134026.GK3840@desktop>
 <20200301170654.GA12013@hephaestus>
 <20200308150231.GD3128153@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308150231.GD3128153@desktop>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 08, 2020 at 11:13:07PM +0800, Eryu Guan wrote:
> On Sun, Mar 01, 2020 at 02:06:54PM -0300, Marcos Paulo de Souza wrote:
> > On Sun, Mar 01, 2020 at 09:54:06PM +0800, Eryu Guan wrote:
> > > On Mon, Feb 24, 2020 at 12:13:41AM -0300, Marcos Paulo de Souza wrote:
> > > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > > 
> > > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > 
> > > Looks fine to me overall, but it'd be better to have commit message to
> > > describe the test.
> > > 
> > > Also, it'd be great if btrfs folks could help review it.
> > 
> > Indeed, a commit message makes things better. I'm attaching here a new version
> > of the patch containing a commit message. This new version also bumps the test
> > number from 203 -> 207, since other messages were merged after I sent my patch.
> 
> Thanks! Would you please send a formal patch to the list?
> 
> > 
> > While adding the commit message I found in Josef's commit that he added a new
> > btrfs test 206, but groups contained test 204[1]. Is it a typo?
> 
> Ah, it is, my bad. This is a merge error and easy enough to fix, I've
> fixed it in my local tree. Thanks for pointing it out!

Then I noticed that Omar has fixed it in his new test.. Will drop my
local fix.

Eryu
