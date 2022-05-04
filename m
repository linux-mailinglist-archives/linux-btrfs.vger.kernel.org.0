Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AA51ADD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377525AbiEDThg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377524AbiEDTha (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 15:37:30 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEBC4C42D
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 12:33:52 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 154847F68C
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 21:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651692830;
        bh=BxZF4PxhBEFEE3gLeRK7dQPGyZs3Z43jCu4o6PIJ1yw=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=QWMcRnWmpM6p+311w9db2IJYaCNYB3BPyDF+UsV24os206fktNf0YoKucKlad5U3E
         HiyrNLRD8bM3x444Rm/awFhbuxqOqvPk4IE48TT5q6zbF/huYNQbWK76+GyDwYd+R2
         WdZYE9lD9Ce1t/VzbIVLQcgkK2j2XUpJWBcs0ZSjnivQBoa4ZQbT+XiLFXx5l8sApc
         hmXL5iCJh7hyc0oAEFcdRQlykvJISAdMDDi28isGSwWnloW8CAR9/gHdv8qwvncxHA
         J6yAbjmmJncCDzyOPZ3aLulrO/t0LD1qgMq9RMnSU0SR+rujCsAKC8QYigvsSaDDyt
         E+dR9dt/7kicw==
Date:   Wed, 4 May 2022 21:33:49 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220504213349.b49135a060ec1d8111794db1@lucassen.org>
In-Reply-To: <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
        <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
        <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
        <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
        <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 4 May 2022 21:15:50 +0300
Andrei Borzenkov <arvidjaar@gmail.com> wrote:

> No, it will not. Some script(s), as part of startup sequence, will
> decide that array can be started even though it is degraded and force
> it to be started. Nothing in principle prevents your distribution from
> adding scripts to mount btrfs in degraded mode in this case. Those
> scripts are not part of btrfs, so you should report it to your
> distribution.

Ok thnx! Would it damage btrfs if I add a permanent "rootflags=degraded"
to the kernel?

-- 
richard lucassen
https://contact.xaq.nl/
