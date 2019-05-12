Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6898B1AC11
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2019 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfELMpQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 12 May 2019 08:45:16 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:48611 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfELMpQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 08:45:16 -0400
Received: from [94.217.151.102] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hPnqr-0007Hn-OB
        for linux-btrfs@vger.kernel.org; Sun, 12 May 2019 14:45:13 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re[2]: Btrfs Samba and Quotas
Date:   Sun, 12 May 2019 12:45:00 +0000
Message-Id: <em99878df7-ca12-4a6e-b5b0-c0544ee43047@ryzen>
In-Reply-To: <d7fe4f26-acec-9b20-6fcb-8628205e614c@gmx.com>
References: <em396f5ac4-821b-44a0-883b-2755971d90c3@ryzen>
 <d7fe4f26-acec-9b20-6fcb-8628205e614c@gmx.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

 >But at least we can determine if samba is utilizing btrfs quota by:
 ># btrfs qgroup show -prce <btrfs mount point>
btrfs qgroup show -prce /srv/DataPool1/Dokumente/Hendrik/
ERROR: can't list qgroups: quotas not enabled

I read, that the same problem exists for ZFS.

 >Would you please describe the impact of above messages?
 >Does it cause samba mount read/write failure or something else?

I have not yet noticed any impact (Syslog is at 26MB now). I am also not 
using quota. Thus, I would not notice an impact due to quota problems.

Greetings,
Hendrik

