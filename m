Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9164BCF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbiLMTOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiLMTOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:14:24 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAE26494
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:13:23 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id o136so2065219vka.2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ziABknadcM28RgPsu/jeZUSNH1wPLyhxbYlC//u8mo=;
        b=cCySR++TRoobJyiz38q5Ie/QA8RKYrBBfcEr+qjcl+oSVejTUMnTGYjOmZEW7kU9VA
         dg9IIjKPzAq/NATuvlz7qf13F3bsZb0cEEt359vu41o6rKWgDqnX2WP/B8n6e+xD49Vp
         0TXDPQbSiv2sKUxxeroiI9+hCYjE+HMe/+IehShp9r2PZTsjsPJgMomvhU5U74Er+AVG
         r20Isv5OidcKkwx4qdKsKvBMerVLEzRruz+po5kwaBXWxu+fiUxVlzkIA3yUOfH5rNAa
         wEnZ7P6Vv7H57bKrjmHjloJ/SGqcRMdgV2JO+VjK/OxvcQ4U3tUymIUhaAEEBaRPGXkc
         Mxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ziABknadcM28RgPsu/jeZUSNH1wPLyhxbYlC//u8mo=;
        b=npo6JhUmePCEWPVTApISm1rB8CeSkX4R28x6s6sKVtWpwOx8nez+UEsOm+eh0slhkL
         id6f9zI2i7JHHuj9qlzb2yE55KXgcoSeJT6b30RmJ8/lpHPdafjlw0HUUCDe2PsN+Bo9
         RCSc2oxkeCuJX1VkOWLpUIdhqT/cGfYLUmiV78EGUu2df5/vm5g9tdmLFTmA9HnPtwXs
         Y8KHxYMeYIBUmd6pJwOSzf6Ujb4PNihPMFjEyx3YCdjkd1Q/BPPKHmh0uShZCiidcKzC
         Iar84YiuuolhOK4obu1/FKleTtfvSYfeuXW6Q5WB1iY7RBRT7cm9bzJZWfHvDDNqSCU9
         QpBw==
X-Gm-Message-State: ANoB5pmNFKpo97+eDfcpmzEzr8IFxeW0fbxB1d57REwm/rYSocnvVVAT
        bz7FuTr+2xkCvI56dN9+UYkPoA==
X-Google-Smtp-Source: AA0mqf5NXD047W4PdhuPJYw/pESZb3AuVBvFPHnJZ5g5TRXFHn30YI3Rq4+4AVjwVKQaIKfsnC764A==
X-Received: by 2002:a05:6122:50a:b0:3bb:fce4:64d4 with SMTP id x10-20020a056122050a00b003bbfce464d4mr15054888vko.11.1670958802153;
        Tue, 13 Dec 2022 11:13:22 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bm18-20020a05620a199200b006ff8c632259sm6038523qkb.42.2022.12.13.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:13:21 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:13:20 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 13/16] btrfs: writepage fixup lock rearrangement
Message-ID: <Y5jO0CTyGq5pw3MB@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <996e43b8178ba3e5f9db220cc9e5d437c3794f06.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996e43b8178ba3e5f9db220cc9e5d437c3794f06.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:31PM -0600, Goldwyn Rodrigues wrote:
> Perform extent lock before pages while performing
> writepage_fixup_worker.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
