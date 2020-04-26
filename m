Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55D1B8A81
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgDZA5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Apr 2020 20:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZA5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 20:57:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A600C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 17:57:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d15so14581269wrx.3
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 17:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtbTOP3OFE1Itqc6jWNOz6ChoBg+nB5aS0LDxfK+4NY=;
        b=Hr3bjWQT1FoK456gAMuSDtz0yVgQimhoF09wFTaBW01swwOrxjylu91hCD3oCinf4b
         sVdUlmYfWbqte4n8BKYis2jDwUAVSFSesZ+hd11yAt7GWQcG679gGF5SmfNUqHAtnB64
         DJsQSEhGE/UCb8MCCYj/g9LM2T+JH0e9jVduFLh3hTcfPmNMwx2xIq9kiqWfojoDWxWE
         TulLbszmmkFhtmIfWaAA7MoWucrwZouQqhvO5MZFQNfApAnKpHXBZP6qyq1ubmE6QC/F
         5gAHuS4z523LMVtkZ35p+dfUsuCymnhGAxem783pRyxvWfbg9CR46V+TPqxWToq6xYG1
         OR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtbTOP3OFE1Itqc6jWNOz6ChoBg+nB5aS0LDxfK+4NY=;
        b=TF+KXFU9Y3JvEbVMTaiPOV+MVyqtms61uc1Zz3a0bpCjPi2sE47WqKD4PlXnqnIc5K
         Bq+jHHbKEKMXcMtKCPreZ2SGjrX+ZVxkV/Bn1gHS6Kt7oUOUGfI94t+B0GZVgqxzNBdy
         HrHno3BmNXuYIPNxJ9H4d001i6Pd79hr7Wl7GaMps2RDbyXO7LmCmLCCwcnoBd7VNZ+v
         6NniwHCzZNOcYENI0unapjxhJOUWIHTtVnA++uINpD/6TtjUdGeL9cHLIE6rfso8W8ga
         2t7/QSc1DrSc1JPY1sVheuy3tMRBpNoROsmvl0hf4qi0IDY9JoRA6GazilH7OBCZTHeP
         d0ig==
X-Gm-Message-State: AGi0PuZlO5kL6bQT7Z3HfouVtvj0h29jPyDAI5nZAqxMfaPAJzFA/sU5
        UZprd7h/lm+v6RouCFtZRv3CTyHRqeuKhQIuMn2gmAIGDl4=
X-Google-Smtp-Source: APiQypIKX/8yq5pBwUIzXR5qSPAPAH8W+lQjtooCNbQFKmzqUqmEH0i8lV6YsnA0vrW0C2T4b4EfTQcVhO/frfKAabI=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr19561798wrc.42.1587862624838;
 Sat, 25 Apr 2020 17:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com> <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
In-Reply-To: <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 25 Apr 2020 18:56:48 -0600
Message-ID: <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
Subject: Re: Help needed to recover from partition resize/move
To:     Yegor Yegorov <gochkin@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 25, 2020 at 3:55 PM Yegor Yegorov <gochkin@gmail.com> wrote:
>
> /dev/nvme0n1p3    309248  368949247 368640000 175.8G Linux filesystem

> total_bytes             188743680000

OK, actually I'm wrong. 188743680000/512=368640000 sectors, which
matches the GPT partition. So I'm not sure what happened.

> ERROR: superblock bytenr 274877906944 is larger than device size 188743680000

I don't see this value in the superblock.

What do you get for

btrfs insp dump-s -f /dev/nvme0n1p3
btfs insp dump-t -d /dev/nvme0n1p3


-- 
Chris Murphy
