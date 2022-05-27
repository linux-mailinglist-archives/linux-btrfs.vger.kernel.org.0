Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30153685D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 23:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351424AbiE0VIz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 27 May 2022 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiE0VIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 17:08:55 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19F92A26E
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 14:08:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E5F173F4BA;
        Fri, 27 May 2022 23:08:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E14CzmDKPQy8; Fri, 27 May 2022 23:08:49 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6EA583F312;
        Fri, 27 May 2022 23:08:49 +0200 (CEST)
Received: from [192.168.0.126] (port=38356)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nuhCO-0007GR-Il; Fri, 27 May 2022 23:08:48 +0200
Date:   Fri, 27 May 2022 23:08:45 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Neko-san <nekoNexus@proton.me>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Hugo Mills <hugo@carfax.org.uk>
Message-ID: <98b7da2.8b0b192.1810759a875@tnonline.net>
In-Reply-To: <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me>
References: <LQBIObJ0wXAJiClnJItZ5QlGJPGLx5G3_cbQYB6Yle5t7wg7-MX233_rkpCs_ybzN9-DWoQBSlPD6EZRa6HDjdo6PWJjFWO0qb4XB7UsK1E=@proton.me> <20220520212751.GE22627@savella.carfax.org.uk> <VHT1Yf4pw4jirz6QjpYj6bPb1zvJ06WStOXc4w1mSC1A7DsH5YQq-mqvzkzZSZriBXwCHuyF11thmlcgSLYFGaBeHGuA5XliXPJVJ3eXItE=@proton.me> <J6n7dr0d6RAArHrDWGrU_uNQsM56Npqpp_tuyXoY7q4rS_2dPzmd4sH14t_w-n_tE80HWdjyUKY2SqwV-iFwBoa55dLfJ3WI7LVsrjTRTVw=@proton.me> <uDip5WTKD2tJ6uP8N0eW91dNpbSShUrHBHPLczGV4l__Z_Wem9uWnG_pCYqcYjren8Gx8Va0iS3AGvCEiFTAC33Lgx_gOMs9KVqb1dh_lnc=@proton.me> <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me>
Subject: Re: [Help Please] Missing FIle Permissions Irrecoverably
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, 

---- From: Neko-san <nekoNexus@proton.me> -- Sent: 2022-05-23 - 08:05 ----

> I had accidentally forgot to re-add the mailing list to the recipients regarding this; I have attached a dmesg log regarding this...
> I had attempted to downgrade the btrfs-progs package to 5.16.2 from 5.17 in an attempt to alleviate the problem but... that didn't work. :/
> I'm at my wits-end and I need my PC to work, as most do...
> 
>

You are having some corruption in your filesystem. The dmesg indicates that btrfs can't find data where it expects it to.

Support is given by the community as and when they can and want to. If you want help a little quicker you can try with the #btrfs IRC channel. There is a Web client at https://web.libera.chat/#btrfs

Did you have some power loss or over temperature issues with the nvme drive before these problems?

Best is to try to boot with a live usb and run a 'btrfs check --readonly' on the unmounted drive. Check cannot reliably run on a mounted filesystem.

Forza 

