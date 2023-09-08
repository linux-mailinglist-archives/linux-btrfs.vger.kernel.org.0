Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873C79895F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjIHO6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHO6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 10:58:12 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3291FC6
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 07:57:57 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-495c2b28211so218619e0c.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694185077; x=1694789877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpd7IDWN3syo+dBMPB/JO7E/b7lbU0Qj4cjU9TccA+Y=;
        b=qTQEXrUus3N7A3SoJoRM62NgvOoMOzK3zPNIw8iZvdeGVwM/jhiVcIh3D67pDoQ6OA
         XWScSgUZ1dYLgj0RfpuEm6jWXMNzXFbrRg/QUZ5K4KQf8OZi/zcwkVZ0YR8xZ6SZn2fL
         SjvdrvFJOWs+mwpdtIcwD5CS2YY4jmiOAQ1IkLCD32c51CTI5J3t/utJinj3q2iIUmxL
         rKIW38ayB0d5qjkr6iNoYNWEn1ygd763oBo98OWLz1N47WvazKPa8tA8x/2MuDEiLU7T
         w5zt7fd1qdYTrni4ZVi/SuQg+qofdfGruzaSTPBchLAy0WHIxjDJmzOGsTtRxQTFqWvW
         QoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185077; x=1694789877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpd7IDWN3syo+dBMPB/JO7E/b7lbU0Qj4cjU9TccA+Y=;
        b=mUqnkskoBNIbrEYJ/lHquEKGG4vZR1Fi0R/6GPcQK6uhG8cqs+mPBLemG1WJVr8SDA
         wsS1wqWA3V5ogqXTigxbfH0NYW+GS6ikCxFegbbuhk6UBEIMRdGtglA1nIIoTzCjdNk8
         hKOwmsGEpJvRCDYmtxdDjnNw3Y0eUeVCuqJSOhgwrEo6T8bO01UcPGaE1qR5p/8diBAm
         1ML9UPCkY1k+CTuWYBi0/+4M14YPPTbPSyj+q5Z7za6DxIkIHlteOhaC2knm/L5z2GCL
         dansrjhZo1cKRQwc0WYkQu7jwfQupstMA9mxh6lPoTofZxlnUM/B1Nt5+7JuYmEDRuhm
         44mQ==
X-Gm-Message-State: AOJu0YwiPnz3tZlkPbVmttm2HNEw/SAAz1tT85r/0uVn6LjLeSTdhe1o
        jKJ5EEbTrThEQg9R1LUFLQLCe5wQY2+Z7xY9KC3WKQ==
X-Google-Smtp-Source: AGHT+IEYfXpZrSCWaPe1BTE++4iR7xJDFJN+oWvj601LuXDXq4+iPCIB9XOHMtzntTFXmE98Evr9JA==
X-Received: by 2002:a1f:dfc3:0:b0:490:47af:3126 with SMTP id w186-20020a1fdfc3000000b0049047af3126mr3122223vkg.9.1694185076958;
        Fri, 08 Sep 2023 07:57:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id iy9-20020a05622a700900b00403b3156f18sm660993qtb.8.2023.09.08.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:57:56 -0700 (PDT)
Date:   Fri, 8 Sep 2023 10:57:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/21] btrfs: prevent transaction block reserve underflow
 when starting transaction
Message-ID: <20230908145755.GC1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <22af99f197c4926165d4f556546379a81ae8a44f.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22af99f197c4926165d4f556546379a81ae8a44f.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:04PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When starting a transaction, with a non-zero number of items, we reserve
> metadata space for that number of items and for delayed refs by doing a
> call to btrfs_block_rsv_add(), with the transaction block reserve passed
> as the block reserve argument. This reserves metadata space and adds it
> to the transaction block reserve. Later we migrate the space we reserved
> for delayed references from the transaction block reserve into the delayed
> refs block reserve, by calling btrfs_migrate_to_delayed_refs_rsv().
> 
> btrfs_migrate_to_delayed_refs_rsv() decrements the number of bytes to
> migrate from the source block reserve, and this however may result in an
> underflow in case the space added to the transaction block reserve ended
> up being used by another task that has not reserved enough space for its
> own use - examples are tasks doing reflinks or hole punching because they
> end up calling btrfs_replace_file_extents() -> btrfs_drop_extents() and
> may need to modify/COW a variable number of leaves/paths, so they keep
> trying to use space from the transaction block reserve when they need to
> COW an extent buffer, and may end up trying to use more space then they
> have reserved (1 unit/path only for removing file extent items).
> 
> This can be avoided by simply reserving space first without adding it to
> the transaction block reserve, then add the space for delayed refs to the
> delayed refs block reserve and finally add the remaining reserved space
> to the transaction block reserve. This also makes the code a bit shorter
> and simpler. So just do that.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
