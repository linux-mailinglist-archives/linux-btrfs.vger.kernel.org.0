Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D6A782FE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjHUSGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjHUSGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:06:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B42DE2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:06:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d6b1025fc7aso3556836276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692641171; x=1693245971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8h3eUpk6Npiw16pFEi6/yrNMHo4xXGpcAxnf9gzP9rw=;
        b=Oo4TZoX+zukKdhjff6aaquhs5ZYlJ7Z2j/JEZgQneIYT3+EI+in6yIEQ+0tAoa0khd
         W0lHYef7KG6k9cKfuGUKhVef6NmtGvg64tsotOx7LPhqlquNatM/gSzFV24O/OHzQgbm
         tmPfg4oXEeDX+6MAc+LPrI4sfDvT3sOILS65B1s44SF8vkHfedkyAzA/M/7E7otmgMQT
         TvAFWM1uuXR1MhMpCBDQ1A0I8P2CZU8TWbptoiSmH1In2LWZV9IGGvnd1xtbjY//cU+q
         xerdcpidxOSBhMsxtMj9uHRjzQPfW7QkoR6B4Z/O1rHxequKARfdbSOI5eDKjMccQG6s
         YVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641171; x=1693245971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h3eUpk6Npiw16pFEi6/yrNMHo4xXGpcAxnf9gzP9rw=;
        b=VcJ7SCQvlOyK+ptzVOjkpl2ugiIlXxYR1/qsBZkcX77CXPP++iFxuHaSgU1o6+YbQW
         xnaMpr+9I0QgBlwBkWlIL/Q9kG48pQymp6ggeBexooAWbYzJAcQC4Y4lFknaTTbPAxtf
         pcb0rJ41ICgOZWJQslV9uwlTGcE0AZ7lj8AKfp54p1aGDyffn0r5w/2uk5Sb4G1M0qYD
         iZBZjU18e/4dGhzPJngN47vgXhVfdlTs0RGSb28wMWhOTJ5HS5ytr3qXsij4PdM4HtuM
         xGQIdR1VeewTZs+bQwM5CmEsyoKaqYbtAA4SSOfspj+oWGNXvtWe9tiOmPsPnmzf5VT/
         p49A==
X-Gm-Message-State: AOJu0YzKRSNr3i4MivG1onXV0fvqYpJEp5A5M55J25totFJL3ci2ynJN
        Sb9cEw+Wfi6ofOhl1RlmJG0MTw==
X-Google-Smtp-Source: AGHT+IGRCPi/nJc19AFL5xPm3aCgWNRkJehOCQnP67DF72MyNR6GD+G7zEkqS6pN5yCnsmNDOXLqPQ==
X-Received: by 2002:a25:ad1f:0:b0:d44:19e9:4c6d with SMTP id y31-20020a25ad1f000000b00d4419e94c6dmr7842431ybi.65.1692641171580;
        Mon, 21 Aug 2023 11:06:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 126-20020a250a84000000b00d7481ed7e45sm1160624ybk.56.2023.08.21.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:06:11 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:06:10 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 10/18] btrfs: track original extent owner in head_ref
Message-ID: <20230821180610.GG2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <1e87e9b6be869c41c9f4f8faab803c9391b5502e.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e87e9b6be869c41c9f4f8faab803c9391b5502e.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:57PM -0700, Boris Burkov wrote:
> Simple quotas requires tracking the original creating root of any given
> extent. This gets complicated when multiple subvolumes create
> overlapping/contradictory refs in the same transaction. For example,
> due to modifying or deleting an extent while also snapshotting it.
> 
> To resolve this in a general way, take advantage of the fact that we are
> essentially already tracking this for handling releasing reservations.
> The head ref coalesces the various refs and uses must_insert_reserved to
> check if it needs to create an extent/free reservation. Store the ref
> that set must_insert_reserved as the owning ref on the head ref.
> 
> Note that this can result in writing an extent for the very first time
> with an owner different from its only ref, but it will look the same as
> if you first created it with the original owning ref, then added the
> other ref, then removed the owning ref.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
