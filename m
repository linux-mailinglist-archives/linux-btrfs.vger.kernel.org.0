Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A462154AA8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 18:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBFRyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 12:54:15 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38012 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFRyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 12:54:14 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 12:54:14 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 48D5T20Fjhz9vdhh
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2020 17:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6HFlWDptCfv3 for <linux-btrfs@vger.kernel.org>;
        Thu,  6 Feb 2020 11:46:13 -0600 (CST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 48D5T15HHXz9vdhf
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2020 11:46:13 -0600 (CST)
Received: by mail-ed1-f72.google.com with SMTP id v11so4891754edw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Feb 2020 09:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Scr8FE9UjeyoTsxN2WVid1ivCmekeTQZ7vseqzqGr4A=;
        b=buzj8gnODah19knPaV6Mi6QsuzwFo3hwkHvAHqAq2OOloaXr7yghNeaLzR+7Tb46dA
         VDh9Ct3k3nb/Yimbc8q7DvSLJKP4sK+w9BkCG+gsxM4h7ZtvHXCbKNbLaFvTXOlhc2sM
         V/mRIR5uMLRnAQ5EEDoleiXXPrH4lGm0xSwimgFSWTwW3kJi87PRk/yCn+eAGYB/fZpG
         A94AC+AY5My2VOd/WJT6Mt3eCYaSsptFx7ViKqn2pjOR4BDCs+4uW/vorFMyg9/VALQ4
         ABG8yHl4ZkxMpOS7hm8mtS3BL0a2mQqyxJunecq7BgYVeKGqeP+LfZqaOu0ankzFFztt
         qFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Scr8FE9UjeyoTsxN2WVid1ivCmekeTQZ7vseqzqGr4A=;
        b=uW7w46DTq93AXd8Nud87hsV+JEKv/JpVtX9h/mncz605R3j0egS2dBjG9WdQeZZk0A
         aisgS28LBWT1kjQz0IGTrjw/5f6uZdNVLbl9e6XkBqRCyAbPQExYsZfHYLV49EkE0MPL
         IyNSpKDHIhWCa+Q/k1TO/tyvJegfYwd7SrqwI/2KzX4SmbFI/iJooJDFSCP6pLPI+W5y
         UoO01Th88wfq1hdLp6NsGfkk5VknWDZbqlTFDNFXlSzWK5VeMF2kgiQRtAoAbNcQbDAT
         wdQNgLwb3C0fNtbdrVWlEwPrAPLg9oMNx/rgy2GkAKEn89s7j81HpxtOJVABBaK2al4l
         vtOw==
X-Gm-Message-State: APjAAAUUI8xcxSBMiVn7fcL6Te5r3hHOyAz/44wmuAP1X6/7s3S6+f/c
        9L+0sGhf2ON8FrItj8e4VBbfFzj5Jvap4zl5HZK5/odGLdoESZpRkwz3m/PIjF0ORUhImQDTErL
        JOn1U1ewJDkcRrfYixO6lAfz3oqO8DZlNi6II0WOceb4=
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16mr4191991ejh.186.1581011172549;
        Thu, 06 Feb 2020 09:46:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwISDoY7FhYmNkmu8GRGeuzURuuinpp9sPz9+WXNebbH8MIMNjfAYenAO7DeZz37iQdefhAH3048DIygCVfyw4=
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16mr4191981ejh.186.1581011172341;
 Thu, 06 Feb 2020 09:46:12 -0800 (PST)
MIME-Version: 1.0
References: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
In-Reply-To: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Thu, 6 Feb 2020 11:46:01 -0600
Message-ID: <CAOLfK3UoH1akySt47Wg8JDDFCHqbcm8otZyEAPp1jX0Ye+41-w@mail.gmail.com>
Subject: Re: btrfs-scrub: slow scrub speed (raid5)
To:     =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Slightly offtopic...

On Thu, Feb 6, 2020 at 11:33 AM Sebastian D=C3=B6ring <moralapostel@gmail.c=
om> wrote:
>
> Hi everyone,
>
> when I run a scrub on my 5 disk raid5 array (data: raid5, metadata:
> raid6) I notice very slow scrubbing speed: max. 5MB/s per device,
> about 23-24 MB/s in sum (according to btrfs scrub status).

Is RAID5 stable? I was under the impression that it wasn't.

-m
