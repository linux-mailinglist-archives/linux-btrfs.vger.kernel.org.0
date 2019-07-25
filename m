Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C135274C83
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbfGYLI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 07:08:56 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35739 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGYLI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 07:08:56 -0400
Received: by mail-yb1-f196.google.com with SMTP id p85so5703538yba.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvbNcebQcgCLFVP2tF0bFneV6kYj++3+8V7Mg1H4Qoc=;
        b=hDnLK3AHm48Yc3iZYdPyktIrxsF0jdiLwbudoUhHwOyTpjjOFWQcCXkqwuMSSKTS8B
         2r8WS3wMYxNhPOWaYcQxBP0I42V8cUutFmzTOqVJyNS++Xlrpk9AFsCBV+yCS2gZcV2f
         +QMRDbpcHJyq1y0a0XqWNxL68owCdYb9ZJTSDi3Lo39xYkqFiaklisuBedElukCQhPeO
         ha2stwhnoqnXCfrF0OFujBPzSSvbk3Ig23WHbK5l0+NQ0+LTyQOhmVHT7E2TPEv9fgm+
         GqzK1jVYBT7BsenhX1iamevnLqu1Ejn2cX3JfoQEIf156VuphGdRbS6SCGs78GWlz5RM
         wGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvbNcebQcgCLFVP2tF0bFneV6kYj++3+8V7Mg1H4Qoc=;
        b=nK+9TvohqlUtz1tIOFVRl95nrsV5Nujup4HJuO0hPoXqyLhTWQ7rxlucF5yR1G7wa8
         HT2Nv5xaRJIoNNvxgW7SRChACvjvS2YBrSfrbaZertmzI5f4qzYBQMl9P9OfnkO3TRBi
         dg3sxoiyPO5KLrMCXCC5rlQKQiYZTAQxRx4eayRjC4KpPXC5BLQqkqGpHgyDmTW7pgmN
         Q2fcIH4d4F2TgshJTed5E8h2X/BguK4zdLYkICcIS/FMO3+I34eqcAw8EG2pPY/hI8Tz
         8e2ojE2h7dSmh3ciU1hVLXYcZ1Sz+0+4Mmmez6Ew9+Lf4uHxn1EGJ+4quqLU7cPY5qIN
         pLsw==
X-Gm-Message-State: APjAAAWOL1cWiGvgdofGyva2VXY0a7QApFwJXf5WNdtMNL4T0TJ01PlZ
        wd+pqg4WFtDB05Nir+ZNJq4DRFGIw8t4V/gGjHg=
X-Google-Smtp-Source: APXvYqz5nTQ7tHzutlW9m0PgrHufPOecVyMqQAyJUKcFYrCwqoqGNnpeJIfWN3MTzxU6HaCpRUE+PLyw11MPK9x1DuE=
X-Received: by 2002:a25:900c:: with SMTP id s12mr37991173ybl.244.1564052935871;
 Thu, 25 Jul 2019 04:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564046812.git.jthumshirn@suse.de> <6601e14425550304e1ba8b5317e74a5f806d6a34.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <6601e14425550304e1ba8b5317e74a5f806d6a34.1564046812.git.jthumshirn@suse.de>
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Thu, 25 Jul 2019 12:08:44 +0100
Message-ID: <CAMU1PDgcQhvQcc-=Q8XZcr5XLjVUxHpx7xD328JZBKTh3QGFHw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] btrfs: turn checksum type define into a union
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 25 Jul 2019 at 10:34, Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> Turn the checksum type definition into a union. This eases later addition
> of new checksums.

I think you meant to say "Turn the checksum type definition into an
_enum_." in the title and commit message.


>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  include/uapi/linux/btrfs_tree.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 34d5b34286fa..babef98181a2 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -300,7 +300,9 @@
>  #define BTRFS_CSUM_SIZE 32
>
>  /* csum types */
> -#define BTRFS_CSUM_TYPE_CRC32  0
> +enum btrfs_csum_type {
> +       BTRFS_CSUM_TYPE_CRC32   = 0,
> +};
>
>  /*
>   * flags definitions for directory entry item type
> --
> 2.16.4
>
