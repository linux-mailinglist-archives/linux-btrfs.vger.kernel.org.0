Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91C264BBFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiLMSab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbiLMSaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:30:21 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730124976
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:30:18 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 3so15542779vsq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjR3Vn5h9iQSklx0KGQjloUdDlQ22bTfwAiLxCDKDA4=;
        b=GEYqonBXAq3sKr50EJJA9aF9moYPrRiNBoJX9ozzH3Z6rzb+NbrcG3dyQlAaX78AQE
         /z502kTI8O7AUuDP1xqNn6OjSYX0gZ7ioJArOi5CLJFYn7SP51vU/TodZHLOi8YCPFyk
         0zj6bg9DtYsfNdZ/EZvsnj2nuIUvCVK0t3B7QWMZjpji1vcO691czk1oiGxP8VLbx4Ab
         CZ9wOtCNWwrVA/IknyEuZxBFHV0N8PFYQM/XojqbqfUx3ko9KuJop+HIJ/3XLkm0AVLv
         fTaRU4qNiSPNBPy8a97+oXn9jzDGhHsV1LfGX+/8CKO7NEpo7sxhKtLWv/Y+DlAcW3bo
         /oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjR3Vn5h9iQSklx0KGQjloUdDlQ22bTfwAiLxCDKDA4=;
        b=l0eLRgbabgD8SGLMXS3hGCC4REjYpMKrBFd6sWB9CxiUXAVNKoJk2svrdkQc3Jk2oJ
         JRrfpOPlUZYyOpzIqhHIHHQCd1wloNOubDwS+y+0G6xhVm+RXvfqQE1salo6nMvkBa6I
         uT1gzTEYZFrl392JIfXdS1dEUvFmML/2oP90Ekz/bPjCnmwnBQgVD/ONcnejngTGBxCF
         b7W3Nm9OZhME/0aycshWlTiYm5H6uLfR3v79AlL7l34miC/oAkpLVDpU9CXRiXY3QKKg
         s6sH4cDgddco/gisNtgyJ1DVH0F/U9v6yqpTcy+TFF0H8WBKCFmYNp3W0NpP8+dAEot9
         iPEw==
X-Gm-Message-State: ANoB5pmH3Evkb/wVaVqKbvsepyKzA3TpgwupzEYePmC220Y97N//Fdje
        ciZTyZyI3CqZGa1RibS7ZMBLqv9hMO3mCpbmSDY=
X-Google-Smtp-Source: AA0mqf7O034IgTzQIIOPRNbKcQNjXFpXO7ETRNcPh9hx6rJf+bOXq35sjq/MURXBMnpEMqXhCZfxYw==
X-Received: by 2002:a05:6102:66f:b0:3b1:1cf:127a with SMTP id z15-20020a056102066f00b003b101cf127amr10594961vsf.34.1670956217276;
        Tue, 13 Dec 2022 10:30:17 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006fcb77f3bd6sm8335794qko.98.2022.12.13.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:30:16 -0800 (PST)
Date:   Tue, 13 Dec 2022 13:30:15 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/16] btrfs: No need to lock extent while performing
 invalidate_folio()
Message-ID: <Y5jEt0pDbivsTJz8@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <259239dfcb4ab26250036c6429c47ff6214ac8ef.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <259239dfcb4ab26250036c6429c47ff6214ac8ef.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:23PM -0600, Goldwyn Rodrigues wrote:
> Don't lock extents while performing invalidate_folio because this is
> performed by the calling function higher up the call chain.
> 
> With this change, extent_invalidate_folio() calls only
> folio_wait_writeback(). Remove and cleanup this function.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
