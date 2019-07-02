Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A580E5D0B4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGBNcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 09:32:25 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33387 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGBNcZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 09:32:25 -0400
Received: by mail-ed1-f49.google.com with SMTP id i11so27352005edq.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2019 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBHT4MGbSEIFpsUbpCD92Hmz/UqSMVRuliM7QIELXYk=;
        b=j7HgL8LpKAbCesVFOuvJRm7HVWp0EN5SRzmlH7DPfY6vfyJqhGs4QPXnVQn+5NlxEm
         EuFdO7AMKSa9wwbHPBDFEOAp8IQxtPKZb6pJi/cZlenwAPJmqB3eUp1nhWUWUO31DUTf
         b7PMx3e185IWIDCIETpyr0qroI0FdqqB1LD3Otr0JhvYJER2QurZbMcvpfxqpIFeFQb+
         n9mfac+JbI2nw1vh+a4y+qkpGhulOZHTaM8F8Nhgris9MNfM+JjlZxE5GlqPM1Xv8h+5
         n0/3LpZmOGNpMP3rUnPqUk2GIz4wxdRSLgPxlkzDxcqSJx1+vSdpLSWwKIU0HY66bBj3
         tVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBHT4MGbSEIFpsUbpCD92Hmz/UqSMVRuliM7QIELXYk=;
        b=TFiYubSmBHjgIdiF0W2F57wokATJnf1bRNlxqDSz0UD1wriv99V3BMO+983Jpmv7OB
         FNHye5fWFoyxCEMKr2fm1DVJgLqa4GqfDrQThDMYo2s6WVcgpZZORj1FUJABB57QHxE0
         k4WWlLjfZXQ68LXq0xAanE79cV7jftF6pPgvKx6FzJ6x1jKKTdO/+vq1iqwt/Wr6IrVJ
         emVx9hmCK3A68kU+9UOg3x0mZr5DBlZgG8RppmaFbNnOna8p7+8Z2w+P+RuAL0ZzjnM8
         zXsccvSOLtqhKn9kHG7h+dR3yd9XY1w6vRhd0k5Mj+YAF470t13VHhjs5ZRS68LIyvyr
         J4ZA==
X-Gm-Message-State: APjAAAXhWtuOmGFcWvH98b+E3OlcvK7z5G/exb324VlERrqspTDVqnAJ
        k08yPgj2dr2txnV1gMzYUbY=
X-Google-Smtp-Source: APXvYqwK6CGW9cP8mQemfnfFAfvDQ+1VeyzltS3p0ZSAjuLXN2osva2FXuk39gJMxiC58oE2JopXVA==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr36622230edq.23.1562074343350;
        Tue, 02 Jul 2019 06:32:23 -0700 (PDT)
Received: from glet (anon-38-44.vpn.ipredator.se. [46.246.38.44])
        by smtp.gmail.com with ESMTPSA id c53sm4723158ede.84.2019.07.02.06.32.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:32:22 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:32:19 +0200
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery
 not possible)
Message-ID: <20190702133219.GA24228@glet>
References: <20190623204523.GC11831@hungrycats.org>
 <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
 <CAJCQCtRrT5pUxOxfKWTC=zt9E=ZxRaiLeBxngqc6YVQEYp8n_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRrT5pUxOxfKWTC=zt9E=ZxRaiLeBxngqc6YVQEYp8n_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 24, 2019 at 11:31:35AM -0600, Chris Murphy wrote:
> Right. The questions I have: should Btrfs (or any file system) be able
> to detect such devices and still protect the data? i.e. for the file

I have more than 600 industrial machine all around the world.
After a few fs corruption (ext4) I found the culprit in the SSD
(choosed by the provider) cheating about flush/sync.

Well, forcing the data=journal at mount, fixed the problem. Same SSDs,
since years, no more problem at all.

Personally I don't really care about performance. Resilience first.
Than options to fix even if the hardware is in the middle of nowhere,
without need to go on site.

Thanks a lot for your work,
Andrea

