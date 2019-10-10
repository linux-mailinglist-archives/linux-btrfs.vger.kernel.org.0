Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA5D2F70
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfJJRRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:17:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34934 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJRRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:17:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so9823079qtq.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eZeTm+p6bfTXDgg/P1kHvx7nfAABDRx39fdSdiMpC3w=;
        b=UfoizV20ORXiGLBA9TZePuKuaRG3yszBWfOR6YjUZ3KUvA2LG2+tTTvqo185kNSDfj
         YaWxuhMFfjUtnBnu9PeY15tfl1DyXo69us7PkBP2eV8TOPAiz3uzEoDsnon+et+NcSCs
         owmsAJw3L0w56RlUVHsQG2OpWWhOKPc7t0bwCCe/BO2TgoftBLGGh+A0aOcrkCz9u3fH
         pFDKWKqYRyyzNw8vRVqJynwpL8bNdyGzJu90gIgO2WCMJqRyFWzDBbfYrwiyHSm0J/hk
         vUZVIdTVPOrMAEluW7S0/Hsyq7iAcqxutY5VsbAlTaUfVYU/LUY/JZfum4dEVkVW0ns+
         Fc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eZeTm+p6bfTXDgg/P1kHvx7nfAABDRx39fdSdiMpC3w=;
        b=afNRm3fqWhaJuOc3J7Xv+2KB5BqtIO3Ynvg38iEzMOzt1uwIF+7C0Hv+ZOSUjnwabZ
         5US5K+DOwCijhyptYRxP+Fvzf9qovpe8nvB2W+b0h1ink+yb8tHH06hnYOYLs1+dKBJT
         ufPqmTmxZ6nv4vrroebzNhbpOZdI2bwpLIaeKaSdwAirjwWYIZUOIJm+8DZIsdNA0lV3
         GBPhh1C0Kn/lvDHJbz2k9FHblWrgw0zkugCrB/OL8c1AbyOdOvZbAPItxG+u0o4baIuG
         FX12Z2j3418ikdewbS05MTQ3e4mPAaryMSiAbCgnOqu8pHV27McaWyi+4Hp9AK70GSNb
         OJLw==
X-Gm-Message-State: APjAAAW+qHW9aqqeuNv1WPKwTkiI+L29TsLC8KiZwbS4KeShA4lRAev3
        +u8OOcWNmwTO22B28gFr8W44yw==
X-Google-Smtp-Source: APXvYqx3g2FjILWCExORWwwoLIgBUpFCoXlsLOGx3g4luiDf775H4qgP26SVN+JUhUSSBouOIdII9g==
X-Received: by 2002:ac8:6ede:: with SMTP id f30mr11483610qtv.205.1570727830848;
        Thu, 10 Oct 2019 10:17:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id 64sm2686196qkk.63.2019.10.10.10.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:17:10 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:17:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 19/19] btrfs: make smaller extents more likely to go into
 bitmaps
Message-ID: <20191010171707.ojldtoqxuz73arev@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <03e95dd7b652034541d964d8b9617ec029765575.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e95dd7b652034541d964d8b9617ec029765575.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:50PM -0400, Dennis Zhou wrote:
> It's less than ideal for small extents to eat into our extent budget, so
> force extents <= 32KB into the bitmaps save for the first handful.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
