Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443365507E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 03:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiFSBh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 18 Jun 2022 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSBh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 21:37:27 -0400
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE2F5A0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 18:37:27 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2jsTotOdvAcBn2jsUoaMzY; Sun, 19 Jun 2022 02:37:26 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62ae7dd6
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=pbaaoEAJdrzxl7SLOD4A:9 a=QEXdDO2ut3YA:10 a=ycG1OLHhaeIA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
 a=pxEkRnIYGiXvIl0L3gPT:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
In-Reply-To: <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 02:37:25 +0100
Message-ID: <000101d8837d$21cad040$656070c0$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+roUFumA=
Content-Language: en-gb
X-CMAE-Envelope: MS4xfMnM0ZUQZab28nVpHjNwOaMNHWKtt9l626uFuB7v7hF5AVbXatW0IBawov+yaYvHMHyKw7qK/PcgGa9sNzPl5gH09LPQomFpurMjLWmzXAAOmL+rOLjj
 fQrBeL0Nh0dGEfvsIeTEr6Iqrne+XctWYgqOn/cOzo6EXq5oYNoYu1d/gKxuNlqN4UuVSHNbcydHQRdPAUt44yy4sdhmMtDFOC8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a RAID 5 array hosted by an Adaptec ASR8885 (which thinks the disk is "Optimal").

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 19 June 2022 00:00
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk

>Mind to provide the disk model?


