Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6F1C912
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENM4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 08:56:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:42638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfENM4N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 08:56:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68438AC66
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 12:56:12 +0000 (UTC)
Date:   Tue, 14 May 2019 14:56:11 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/8] btrfs: Explicitly reserve space for devreplace item
Message-ID: <20190514125611.GC14840@x250>
References: <20190514105445.23051-1-nborisov@suse.com>
 <20190514105445.23051-7-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190514105445.23051-7-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
