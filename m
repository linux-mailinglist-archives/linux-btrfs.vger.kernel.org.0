Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9003A5147FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355360AbiD2L0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiD2L0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 07:26:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1A32ECF
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 04:23:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w19so13434362lfu.11
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2WdrCSkYYVpFynoCpJfz0oM5EkIoazXwFGNZ6ja9Fe4=;
        b=V1LBEZeTPQRwU4CGMG/o9RK8Pr2JzpMYewwckSnevpX8pwrBpL7PLMtVbg1SwcTsmd
         14+28LCLYKItSoMl6rDW76YxkJsSV47wK3qIIE7VkfJkwbwDuAW5TdV1m0jaKxRJiuGj
         7RKMqBuQ+ARZh8TRpClIdPeU0DbyR0TpZDNPLMRY1o64Rp57Nimr7bhtkSAhm3CicINy
         D7eCA/ewRs3e3QKDrvhWihDRZmNCmrKHVkI5eRQFF085EsueRgPsp9vp8MfJPy+a8Uqv
         ly0cSd/8OEGSdnWQ34LlPEUbEAfqPewCrA7Pw3FDfzBBpjg1HaVa/E7j+f9QuQ+BXyTP
         Tusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2WdrCSkYYVpFynoCpJfz0oM5EkIoazXwFGNZ6ja9Fe4=;
        b=H/N1wwyVDbFDpMugCsO8OCET7JoAsw1E7KlL4ESivnxbljugEIwJrqhF+gmzqal7ye
         coCBBWfGi5Vf63+lDqnQTZ8G/w01K0oi/PI6K9sNhMLqnA2/9Su8KUzUyw4I5OsmaYVt
         mF1J63P+f4g4k9UjKWXpmnhTHtgCoT7HQhb1+SAVsgecDpgQiPLTb3CTcUWdvaAwOEjs
         Tbg1V65AsNvP3Q5lfK9BW0UeITrF5xkwj0zv1JtEfs/sCAPSBGuUWA/olKnHs/2HC37w
         QFsi7lIzttSJVC6jmXbHlMQK0Ir02NlHbCViLVkmfSO5pwsD6pCrf5lZCmHgOaNedIFZ
         GO4g==
X-Gm-Message-State: AOAM533Oc3fUGWScqAbc5VfNKU7cXTFGpzXDMb3HTsFLUjgAxQuAphed
        VIL1YFOlug3HU2yJ2plU3epSTEYjinM=
X-Google-Smtp-Source: ABdhPJzDjV7M1X12dQZgeBNMqij5f+ZeYJdaGiKQ93f35LdjChltRVb/ca9kLXfo8Z7Y+w5L3eWq6g==
X-Received: by 2002:a19:5f51:0:b0:471:f43a:d830 with SMTP id a17-20020a195f51000000b00471f43ad830mr23783201lfj.348.1651231391208;
        Fri, 29 Apr 2022 04:23:11 -0700 (PDT)
Received: from localhost (80-62-117-19-mobile.dk.customer.tdc.net. [80.62.117.19])
        by smtp.gmail.com with ESMTPSA id i6-20020a198c46000000b0044424910c94sm216921lfj.113.2022.04.29.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:23:10 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:23:09 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Inhwi Hwang <dlsgnl1@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Question on file system on ZNS SSD
Message-ID: <20220429112309.nz2x6zdi6qvjqcip@quentin>
References: <CAGy3qQDeMHQMx6ULiw2uGfiJWzumpyb1jhKgizF5UsRppAoRPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGy3qQDeMHQMx6ULiw2uGfiJWzumpyb1jhKgizF5UsRppAoRPQ@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 03:26:45PM +0900, Inhwi Hwang wrote:
> Hello,
> This is Inhwi Hwang from Seoul National University Distributed
> Computing Laboratory.
> I've contacted you to ask some questions about the file system on the ZNS SSD.
> 
> I read the documentation of BTRFS on zoned device(Zoned - btrfs Wiki
> (kernel.org)).
> I want to check the performance of BTRFS on ZNS SSD.
> I attached BTRFS on a ZNS SSD(ZN540),
> but a basic write test using fio failed and raised errors.

Could you also post the errors you are getting?

> fio command : fio --filename=/mnt/nvme1n2/test.txt --direct=0 \
>                       --size=10G --rw=write --verify=md5 --bs=128K
> --output=${OUTPUT_NAME}
> 
> Best regards,
> Inhwi Hwang

-- 
Pankaj Raghav
