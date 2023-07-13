Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1120752B93
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjGMUX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:23:55 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900BB2120
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:23:54 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bff27026cb0so1076354276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689279834; x=1691871834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4UmUMlr0HTdVd+pQsN2X2j+j+wsy/hrnjyfNUgriS4=;
        b=NcxUVCukm/9VUxd6jFDkGa/nAt7yu7yagMgItfX/N7jXb45yKQYtmRzflE5Zf787Nq
         VMg4KBL+Oy0PrZv7Uab37OHKrrWbF4Zl3hLsk9W63A6q0DU2rDcZcFlmleIOD+HBtXIc
         whg9QQUU9isZHTrOxrDq536XCcdmBo183KAO8pCW0SP4ng8RRRAbM8+8MkHac4yI3goh
         jSGmxTE3wOokHrS3fnAAzTtXuE7s2XA7SD2VzsgDzqoKn6iMw4gzfAznRrWpMMVLPyTd
         IYrKDZfbKAJuZS3SJKjE17sDHXYLT2qhOP1DDBGTgsGWvf8JNS/4uaOSLkzRIDOpm6mO
         rIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279834; x=1691871834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4UmUMlr0HTdVd+pQsN2X2j+j+wsy/hrnjyfNUgriS4=;
        b=VlSYzTkg0HVSpcAKtwqR9+NKG9JL5KpRVG3FpAHNmz4aENN4tHLlMN6E95cGVDdyo1
         fCY/4ljqBXzTwWcLtu2V1uhXQJ7EJPBGJyhESrhFCE3hQWgR44rf9BUdOTNbm8BW/HOz
         uWw4IciOQqRqRWReK81AMwBbc0Lf9XOdiNoj8yyEcbcVZ8BbMUFl3rZLc0EStteEDfd1
         ZgRu4JvQ5YekUfdSsFWwnFg+CxUiS4ZnFw6dgD7skCocNpuSykG4oDE4ScN6HPcdyGuy
         Thqs8IABy332M++WEjftss798JanSLGsepLCqFbHwz5fjwqDXTy91iGvbohHckImWatr
         V6RA==
X-Gm-Message-State: ABy/qLaswfHj21BTpN/m4BO/1UbbElqw5Fq0YoWBqxURQAngvSrGMzLA
        rb7KgA/DcTFytCYlmYEuemX6HA==
X-Google-Smtp-Source: APBJJlH+XslCZ3jXJHQMPgkjC/y3nzJn+qAc7xUwCJ+TPh+6tRwqwkx/ZzBbl0LGO0RHlIPLuHkfIg==
X-Received: by 2002:a5b:8ca:0:b0:cb1:d8a5:b3c4 with SMTP id w10-20020a5b08ca000000b00cb1d8a5b3c4mr2361722ybq.37.1689279833615;
        Thu, 13 Jul 2023 13:23:53 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m9-20020a258c89000000b00c4ec3a3f695sm1479142ybl.46.2023.07.13.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:23:53 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:23:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/8] btrfs-progs: simple quotas mkfs
Message-ID: <20230713202352.GW207541@perftesting>
References: <cover.1688599734.git.boris@bur.io>
 <19ca469539472675b8cdb0d807e59cbd4e081fd4.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ca469539472675b8cdb0d807e59cbd4e081fd4.1688599734.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:36:24PM -0700, Boris Burkov wrote:
> Add the ability to enable simple quotas from mkfs with '-O squota'
> 
> There is some complication around handling enable gen while still
> counting the root node of an fs. To handle this, employ a hack of doing
> a no-op write on the root node to bump its generation up above that of
> the qgroup enable generation, which results in counting it properly.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
