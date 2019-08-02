Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA77FBBB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbfHBOHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 10:07:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44663 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHBOHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 10:07:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so42946977qtg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svWDsGSEgSRqG6IOp68mmj+IOfFDRdVQJ08EwBzz0f8=;
        b=uINLmnZIfg4B+gCrBxHcXl+fe63GmHd4ossyINbPjUDMwbzok++YnxKSLNkuEVy+PY
         dLqv8xnhR1fgRlrgRZIFEG6CJkSVi8nfpSrZAeu1ZlywPHUW2Y2h/DOSPeWm9S9z9HVC
         wpIdhp0j+zreH0DwS9DzC506rT4YW3Gyx6yiJuXfceQ5VS06T7fmmaSxNtZ413uWI5NJ
         cer668mQoz+7Djy/X7hKWYw80hEpHD0P7+cNH0f42cG4QN4o635ti48PuuB7gDykaIpP
         7P17gidDEupyNM6XxOZ1ZncamyDD2tXQzZPypuFl8MVWWcJO1fJqX2zDSeEgwJKvSoWT
         +osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svWDsGSEgSRqG6IOp68mmj+IOfFDRdVQJ08EwBzz0f8=;
        b=YxSlzljgvaLGHOqciUSrKA6P5cxKN58SoUDoIBmfmYjR/DeRebI0nAtu4h2fKNpnKH
         LOpG2JBtAedNwMoSRTkwFrSAnW+lSYP00MFRUHmAs2MDKRym9jZhPqlnfrSonlhOJsfx
         h4jyVfPJGrmeqJpxpdZp06/Eiiu1L0tbs2MBifZL8KV45V1Sn7uzpBVENhF1/BEPdw9k
         mpyrXCrpo/4lNwtfsGQJURBM2JMxX3KWSVVrPAuv3PYG9RoE8XbcFbDeKFE+JNE8pRkh
         IRLQ8FWGgTX7SX3yYK7IvG2AGhZoj2vgFaOmBsPw13oKeuZoMnr0K90Flo/ScRAIyMHM
         yZNw==
X-Gm-Message-State: APjAAAUA+fFbaAwzH2EzsqcyiO9rqTeDM/bmU0b5ZrnT+/iXabvFpnIb
        ekz5ldXzSVMBNvp4qKZ1BlAxvpsQxDQ=
X-Google-Smtp-Source: APXvYqw3CrydXKKYLu/jbI9nw/JVrz+KXmH7eRynAxR7v/lLCyuBRG9TD+8UnX8bdI8s1PRnYQPwYQ==
X-Received: by 2002:a05:6214:1c5:: with SMTP id c5mr14984082qvt.97.1564754839268;
        Fri, 02 Aug 2019 07:07:19 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v7sm34683757qte.86.2019.08.02.07.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:07:18 -0700 (PDT)
Date:   Fri, 2 Aug 2019 10:07:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/25] btrfs: migrate the block group code
Message-ID: <20190802140716.zmyytedvuzwq6gbn@MacBook-Pro-91.local>
References: <20190620193807.29311-1-josef@toxicpanda.com>
 <20190802135638.GW28208@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802135638.GW28208@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 03:56:38PM +0200, David Sterba wrote:
> On Thu, Jun 20, 2019 at 03:37:42PM -0400, Josef Bacik wrote:
> > This is the series to migrate the block group code out of extent-tree.c.  This
> > is a much larger series than the previous two series because things were much
> > more intertwined than block_rsv's and space_info.  There is one code change
> > patch in this series, it is
> > 
> > btrfs: make caching_thread use btrfs_find_next_key
> 
> I've merged 1-10 (ie. up to the patch mentioned above) as it applied
> cleanly on current misc-next, the rest produced some conflicts.
> 
> Although most of the code is moving from a file to file, I fixed the
> coding style as this is the perfect opportunity to update code that does
> not change often.
> 
> If you're going to send more patchsets like that, please do another pass
> after copy&paste of the code. Also note that the SPDX header in new .c
> files uses the weird // comments, unlike headers that use /* */ .

I'm working off of next-fixes on git.kernel.org, and it looks like you have all
my patches there.  Is there a different branch that I'm supposed to be working
off of?  Thanks,

Josef
