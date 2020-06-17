Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217151FD2FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQQ7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 12:59:33 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.33]:24262 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgFQQ7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 12:59:33 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 46C70C1FBFA
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 11:59:32 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id lbPQj0iDgXGIklbPQjXP67; Wed, 17 Jun 2020 11:59:32 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jRnTwXRhW1YsZlBBYJqlnqnLYftIXv0TGj/+hVvp9ss=; b=jQ4PvF7vknJ+PWaEuj+wslosMx
        eSREAcKrnRJtWvzDrVwBzBa27W8JmegFGD7zd+mkJxUgguAgy/N/jE1z4HmZVyAULdzCJeE5uWNe1
        uFYBPNr5Dw5/TnIO+FFaetuHBX8f9nxk6CEZGN0/g1mO7V+/R0ZDa1iHnrBck/5PtB7zuEY1nWXBm
        RXil/LQkQ0xk7IYWdLiqfGAthRmOzywkHrbQTNxIWo99pciO2k3un+Flcu6vZ9d/7REMSP2aPzk/w
        R7U5kLHUSxojAWFDt8Ww37lYfSMLsEdMzR2evDuAZ6iJDMJE32LBF6JSTzY9b8qiXcuLlLs4vr/JW
        GnpxlR0g==;
Received: from 189.26.190.97.dynamic.adsl.gvt.net.br ([189.26.190.97]:42886 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jlbPP-000Cq3-MD; Wed, 17 Jun 2020 13:59:32 -0300
Message-ID: <2513368d4a16db8543817288aabc910e5f95ee86.camel@mpdesouza.com>
Subject: Re: [PATCH] btrfs: Use fallthrough;
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.cz
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Wed, 17 Jun 2020 13:59:27 -0300
In-Reply-To: <20200617160714.GN27795@twin.jikos.cz>
References: <20200616185429.1648-1-marcos@mpdesouza.com>
         <20200617160714.GN27795@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.190.97
X-Source-L: No
X-Exim-ID: 1jlbPP-000Cq3-MD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.190.97.dynamic.adsl.gvt.net.br ([192.168.0.172]) [189.26.190.97]:42886
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2020-06-17 at 18:07 +0200, David Sterba wrote:
> On Tue, Jun 16, 2020 at 03:54:29PM -0300, Marcos Paulo de Souza
> wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > Convert /* Fallthrough */ comments to fallthrough;
> 
> You should convert all instances of the fall through comments.

Indeed, just found more cases. I'll send a v2 soon.

