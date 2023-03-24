Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316D6C7D6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCXLoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjCXLog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 07:44:36 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17A1EFF3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 04:44:32 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id n2so1207117qtp.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 04:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658272;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhjMPH+bA8zncYW4ZB307FW/09eERS0VrZbOYDEuM1c=;
        b=mE+LjTHFl4X/7oggSpJKbQhmRMvjMWs2Ct3I1iTO5UbsILiU+L+tpaBYEILfiGG2yF
         ryySy4/VYxW6YpUvypJnam+GccAN5AR/s70PHu+QVIT45p5LQS4I+z0hi+pRhgExfA2K
         o+tEUEy47gvLT+3PAO1WunMnSlNmYAimHpG0dsyp+uWrdkjrpZZUhFGQu9bAZLguYqzR
         FelgCFwz8UN62dIwhIEhUpJ295kG6nlv1TtnsFYF0m6H2d/PU6N5FNNjyRYcOi+LhjPo
         HY4NlFrgAs6N4x+sZe1/z7J5k/5fswF9gx0HFsVQodnx8kpGRmuMa0Hsa/Br/JJq/D2G
         NqXg==
X-Gm-Message-State: AO0yUKUQT0O52kGb8rOkI21hd6SQqAnoSjD1a8i1rS3cqjUYpy/TvjMK
        +rQGTCcXVl1/Aq62/9dxTbUZYD5sWx4=
X-Google-Smtp-Source: AK7set/waDCMq1oQpLfNhmrzGBQTFdiNThCNCpYEQoXNwi6OUTndgtAfbr2m8+TxWH9hsa+GoVa5rQ==
X-Received: by 2002:a05:622a:1341:b0:3e3:867e:17f7 with SMTP id w1-20020a05622a134100b003e3867e17f7mr3842840qtk.15.1679658271485;
        Fri, 24 Mar 2023 04:44:31 -0700 (PDT)
Received: from smtpclient.apple ([2601:47:4301:d340:a499:339d:f8ab:a94d])
        by smtp.gmail.com with ESMTPSA id h9-20020ac87449000000b003e3914c6839sm2056916qtr.43.2023.03.24.04.44.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:44:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
From:   David Ryskalczyk <david@rysk.us>
In-Reply-To: <ZBz2hvO/NRqVZhvQ@infradead.org>
Date:   Fri, 24 Mar 2023 07:44:20 -0400
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F634B09D-A746-4FE6-851D-7C26CDB00819@rysk.us>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
 <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
 <ZBwJQcvt2TcqoCRh@infradead.org>
 <2F36C097-7549-49D8-8C70-C254A93FAC74@rysk.us>
 <ZBz2hvO/NRqVZhvQ@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mar 23, 2023, at 9:01 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> Any chance you could try 6.3-rc3 or the latest Linus tree on this
> file system?

This issue no longer occurs for me on 6.3-rc3.
