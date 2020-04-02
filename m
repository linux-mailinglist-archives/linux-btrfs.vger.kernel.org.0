Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C446419CDA6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 01:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbgDBXwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 19:52:32 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37481 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390301AbgDBXwb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 19:52:31 -0400
Received: by mail-wr1-f43.google.com with SMTP id w10so6451025wrm.4
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 16:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVEoY10xjnKcTzoyeyxL+su+o9LkF22+ZPnShOkGXQA=;
        b=DJ6W7c++Cu9Wu++5VfR/UskrKJ0sIJsXOXt1Zmz+3Hq6/8vr+H4VLTHEkuxlPHk8py
         ot+dT5AdOJcjVeMSPxuVeqSKVdL1B9awqZueXMhyFSHG8Tx+quZ6fmDb+H/EODm38RRN
         /FSNoLI1ajiYeNvrpLgvT6nImBG/95Wb53wD54n1fxq7dxRIVDETdFPeceRw1zeody7A
         oD2jgy67DFcL3AT/Z+o5nACiUUhZqLgmSg/RIhm59WSYyj2dho5iwOghn+m9p9doGiFN
         IA22i36WbTFmUtpYOpWzYbsreHjuf20349VNJ75t5Eyze8EhLNnfC4kayAGZPs8o0ber
         oxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVEoY10xjnKcTzoyeyxL+su+o9LkF22+ZPnShOkGXQA=;
        b=Dkmz5EHiWnouEIdD4DmlACagMnQHdBrkcazwjTdrL9jI2oh8uYx1XjFHRaqhcBVNYt
         6/cvmTIKy5sD6lb7m8Jw0ooTY9z9lH5s3cUEhtLgoPOp+Y8WsC8ZCt3pgbIZdxCX6A3Y
         mQdbR3U2bOcVsUXonzjkoZVN54aPYhF9VKDub8RELokZwANU1jrAYDwk06apx9zCZrok
         KWp9eza/sVzwj9qQPnE1H9x4+RkaObnM7Zz5tOyBYpDheSJXh+BQUmD0k8SFfILDwjLM
         6q15bAMq6zXyikWBGcT9GWp8tyn/3BbOZZevpQBYVFRYrWMewVcnK4RVrPSsjMbeE837
         mtZQ==
X-Gm-Message-State: AGi0PubeFGddZMGcvJaWFMJiSQboiH/zB5qIV3bNNmlpsqLvj3cYZl7p
        C9jDXTrg2MxsZ6Ym1C7EIp5+l8IhJ66ZFboyblIIng==
X-Google-Smtp-Source: APiQypI62CwAtSmZYyh+dTwK3k0d3Gc8rGb3bkLBnhCCRYeGRX2JCZ9s7B8sYCUxObXJ9wtBsJ3zWBdosxVS/2+vnfk=
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr6021539wrs.252.1585871549775;
 Thu, 02 Apr 2020 16:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
In-Reply-To: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 2 Apr 2020 17:52:13 -0600
Message-ID: <CAJCQCtS44Fq-uKdduMLB7TFh4Dme3RPOvtfuXuATkJBujcVakQ@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 2, 2020 at 5:09 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> Any thoughts? Perhaps someone else was already aware of this problem and
> had thought about this before. Josef?

Upon degraded, there is some data that is only ever written as P or Q.
This requires two stripe elements to successfully be read to
reconstruct what is missing (because it was tossed, because of the
degraded state). What about falling back to raid1 (for raid5) or
raid1c3 (for raid6)? That is, freeze the raid56 metadata block groups,
and only do new writes to raid1 or raid1c3?

Alternatively, disallow raid56 for metadata going forward. Make it not
possible to use -mraid5 or -mraid6 at mkfs time. And explicitly
recommend everyone convert. This might be the easiest fix.

-- 
Chris Murphy
