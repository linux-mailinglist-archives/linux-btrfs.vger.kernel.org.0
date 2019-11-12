Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE824F9C42
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 22:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKLV1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 16:27:04 -0500
Received: from briare1.fullpliant.org ([78.227.24.35]:34002 "HELO
        briare1.fullpliant.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727151AbfKLV1D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 16:27:03 -0500
From:   Hubert Tonneau <hubert.tonneau@fullpliant.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Avoiding BRTFS RAID5 write hole
Date:   Tue, 12 Nov 2019 22:27:04 GMT
Message-ID: <0JG92D511@briare1.fullpliant.org>
X-Mailer: Pliant 114
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote:
>
> Instead I would like to investigate the idea of COW-ing the stripe: instead of updating the stripe on place, why not write the new stripe in another place and then update the data extent to point to the new data ? Of course would work only for the data and not for the metadata.

We are saying the same.
What I am suggesting is to write it as RAID1 instead of RAID5, so that if it's changed a lot of times, you pay only once.

The background process would then turn it back to RAID5 at a later point.
Adjusting how aggressively this background process works enables to adjust the extra write cost versus saved disk space compromise.
