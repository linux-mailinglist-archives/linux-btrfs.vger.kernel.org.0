Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2C64A7A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiLLSyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 13:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiLLSyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:21 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB6B7EE
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:54:17 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id jr11so9172902qtb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpeFdLM/btLsC1tMSIKN3eB50MuCJFgtauNoydEMQVY=;
        b=QIE4MfQcFkwDHLO3PyJseIKRu1/wRkyw6dp9+yOoy45uyjLvSrLshLmDsU968JdqWk
         zY99ypagZRDARRoO9OpGBs89xEnGj15447g4wQOVpdb1f+9TCuBN7t178A00eEjsK+DJ
         6rygSyQmYxLUdU3q/d9lcPIuTc6ibaEh49eCkjDlr/gmugbD4Syn6CD8I/Y6XLimOZu+
         PVZJ0r3YVdfAatR4NMBwejFRyiS1253iTrPQb3/JO4u/JMxgjp07KxI19Nv2Ale3KfnH
         S0du9yu7aeWwUzuH3Zh7/I+sy+4bW2iw0/LdhKxR7Z225tqC8d3nxNyUTqreNaKZTmu2
         vIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpeFdLM/btLsC1tMSIKN3eB50MuCJFgtauNoydEMQVY=;
        b=b7xgtgZANXiQMICVhNwqdkX5dZ1kL7m9Qm3C4kQPg5X7z2B3OX5jSCd0awW9A4tUum
         RqTaBSmn7EtOXW8zqSt2KwpilLY1ZvITQfAsqa5eRxiP65LtE7fhdH3EbNek+pGJ4n40
         N+7Px7JR/rJOq8aj7L5ReI/te9KHhFg8UJTPmfyuwfzoz3wHeWyVQplY1LPZcSf/JcS5
         IPOvPyYYaFt9dlm4E6MQei5EOu+eNN5Ymg0TCDxA9XL1T6EefsiNJtEUKSMiRTa+Z/UZ
         VrC5N40Zy2rnjUiDjpms4R6GQjQkPsEKAoxMLMvPFrFtVJ6/uJsdXSMN0vVgNC4KxIDI
         XMvQ==
X-Gm-Message-State: ANoB5plgZ0EWxXnX+O78h2ylyGTWfg862Ewe9kEJQwfig2g0THomiZCo
        SHiEE5Seh1hD5djwjxsTrjzGIA==
X-Google-Smtp-Source: AA0mqf7s0UFJpHg5U37JixX6Lkis9IpOkl+cCBmIX1waFk35X+uB74HPtlx9HMatk2V7f55FXvipBQ==
X-Received: by 2002:a05:622a:488c:b0:3a7:ed31:a618 with SMTP id fc12-20020a05622a488c00b003a7ed31a618mr26966012qtb.7.1670871256102;
        Mon, 12 Dec 2022 10:54:16 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a241600b006fcb2d3f284sm6394281qkn.67.2022.12.12.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:54:15 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:54:14 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: use file_offset to limit bios size in
 calc_bio_boundaries
Message-ID: <Y5d41lL0MSBqTto2@localhost.localdomain>
References: <20221212073724.12637-1-hch@lst.de>
 <20221212073724.12637-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212073724.12637-2-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 08:37:18AM +0100, Christoph Hellwig wrote:
> btrfs_ordered_extent->disk_bytenr can be rewritten by the zoned I/O
> completion handler, and thus in general is not a good idea to limit I/O
> size.  But the maximum bio size calculation can easily be done using the
> file_offset fields in the btrfs_ordered_extent and btrfs_bio structures,
> so switch to that instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Can you add a comment to the code as well?  I'm going to see this in a year or two
and spend a little bit scratching my head as to why we're using the file_offset
here.  With that done you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
