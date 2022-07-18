Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9048577E66
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiGRJNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 18 Jul 2022 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiGRJNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 05:13:10 -0400
Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EFE11810
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 02:13:05 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id DMoGo47wICVxYDMoHoh656; Mon, 18 Jul 2022 10:13:04 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ENUVbnVC c=1 sm=1 tr=0 ts=62d52420
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=iox4zFpeAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=jAoSBy5WYTWg5-HTY24A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Nikolay Borisov'" <nborisov@suse.com>,
        <linux-btrfs@vger.kernel.org>
References: <000001d899d0$57fb6490$07f22db0$@perdrix.co.uk> <bf6ecf74-bbd2-5f3c-a5d6-0d182a61636a@suse.com>
In-Reply-To: <bf6ecf74-bbd2-5f3c-a5d6-0d182a61636a@suse.com>
Subject: RE: Odd output from scrub status
Date:   Mon, 18 Jul 2022 10:13:00 +0100
Message-ID: <004801d89a86$960eb0f0$c22c12d0$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQG0I+mo95iLQgivBE5YQgylXxMxEwH5HZs6rbz74pA=
X-CMAE-Envelope: MS4xfGYGk358J4Tvgn2SHfqzTnQK9s1AcxM2DkQfoO+PznpcB7d6cWcCt0Qzv1izcxmAiKI7CrbSUiTBzWuLdlYmbgbWIrLgx8F49vGYlyt+LFERF5gXTJ6K
 7ylm80N+bNaNJ471iP3GidwERpPOK66GbGR7sjLdg7Blfd2FY+DrdhvQ9Xmmep4u0Ni3kNeOyx3+yIPt2h2AozwOsLh96Sv5Nak=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hardware Raid 5  It may have got confused because I did btrfs subvolume delete of a few subvolumes just before I started the scrub?

David

-----Original Message-----
From: Nikolay Borisov <nborisov@suse.com> 
Sent: 18 July 2022 09:02
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Odd output from scrub status



On 17.07.22 г. 14:28 ч., David C. Partridge wrote:
> Total to scrub:   4.99TiB
> Bytes scrubbed:   5.48TiB


What kind of raid profiles are in use on this filesystem?

