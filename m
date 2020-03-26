Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA27E19466C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 19:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCZSWT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 14:22:19 -0400
Received: from mail.itouring.de ([188.40.134.68]:52700 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbgCZSWT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 14:22:19 -0400
Received: from tux.applied-asynchrony.com (p5B07E2B3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id 9B625416B3B8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 19:22:17 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 647E0F01604
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 19:22:17 +0100 (CET)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Q: btrfs and device readahead
Organization: Applied Asynchrony, Inc.
Message-ID: <f6a28da4-e485-e948-6b33-091f703bb67c@applied-asynchrony.com>
Date:   Thu, 26 Mar 2020 19:22:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

the recent discussion/fixes re. readahead got me thinking: does btrfs
use/benefit from a device's readahead setting (/sys/block/sdX/queue/read_ahead_kb)
at all or it it completely ignored? Increasing the default from 128k
can have drastic effects on other filesystems, but it's not clear (to me)
whether this setting is ignored/circumvented by btrfs.
I believe (but do not know/understand the details) that this relates
to the implemenation of fs->readpages, which AFAIK is about to be replaced
by a better/common readahead implementation..correct?

Thanks!
Holger
