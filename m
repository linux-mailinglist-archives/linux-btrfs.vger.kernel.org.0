Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6240545A5AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbhKWOdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 09:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhKWOdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 09:33:50 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01893C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:30:42 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m25so19934641qtq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMxscpTz/tCglODRt6NpuideCUGmcuzNYy7Rg9N3+08=;
        b=5icCboTrVYy0IlhREW31/o84Jd2fSQp8OKBiHBMkcgIVnr4oWHx2tmn/qS0z2UAZ78
         Abqni5Lfs6vMSoMbHvLgATQFXqcorKghEt3VQDiwxOcLNLa/6n2NOIbIZ92o1uzLBYJL
         l5XgGn+gmiM67g4bt2gTwI6UwB+IMRYaYNMnvrDvk9NJxcRizc91IARtZdMcDYL+1P9b
         NEosavFozl/aYYdEcQRqCalTt+28HRGY+2bMUxGHjeMltPfepNKsBhfvstaCOLG5baBK
         dwYi+FzByLQeWhVz3Z8o26q9UowVsVlfeqEPEPkFpC3bqt7hrwt723Z+jZRLuEkoz0oM
         8SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMxscpTz/tCglODRt6NpuideCUGmcuzNYy7Rg9N3+08=;
        b=A3pN3FMsNGgZEe+LQBEmktaKKThk1dEjFp5HLfZfTmgfGWQYa/xTN3n53ifqrY72ds
         bt6fdT0FcrdsK01DpOkiRVTejwbYfZE4fuSZoC1ND1a3tVLtmL8TVaRl+8/KVlh0nN9X
         z5ZR7GMBaPWDWdrVXxQwkd0+M5UJqDnsThDQjq95oio6Ys0Z5FZrHx6W0nGbDqSnATmv
         9Ib8+jq46eI4Pa99OIpxx8nJrzglsuyuXgCIIpHvVlkz2P1czSohYpyCuQER7Fgw4szh
         YltCUC1KR8P59X3rUtpiAWsJlDC2WvOleA7OksZkepIPMN/ENHD2ALiERpn6rEDhIDoy
         S2lA==
X-Gm-Message-State: AOAM5313CduCnGrHkVmPXc33rfDY/gQ90KimR7SBAiw3f9HWIUKFgFPF
        OPcADGFml8hC/MGIAKJ4E25dhbHKbNrnxQ==
X-Google-Smtp-Source: ABdhPJzvKwLFz6Fhqw6EASUDZ2G8w7s6bk3I5yo3GnuH0v/JeTmKWnAmWYi4Krs0tpHQx9lNWa6GXw==
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr6746927qtd.109.1637677841070;
        Tue, 23 Nov 2021 06:30:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b5sm5961547qka.51.2021.11.23.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:30:40 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:30:39 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: eliminate if in main loop in tree_search_offset
Message-ID: <YZz7DyYGk49mlxJa@localhost.localdomain>
References: <20211123072342.21371-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123072342.21371-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 09:23:42AM +0200, Nikolay Borisov wrote:
> Reshuffle the code inside the first loop of tree_search_offset so that
> one if() is eliminated and the becomes more linear.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
