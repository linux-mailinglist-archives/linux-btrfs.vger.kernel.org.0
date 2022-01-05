Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BDD484C2B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiAEBiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 20:38:02 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:59618 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiAEBiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 20:38:02 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 366F540580
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:38:48 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id E66A2803540A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:38:00 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id D72628035419
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:38:00 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9iIhF4Wx60h7 for <linux-btrfs@vger.kernel.org>;
        Tue,  4 Jan 2022 19:38:00 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id A739A803540A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:37:56 -0600 (CST)
Message-ID: <9dbeb4327f5e42f0fd45ee4a348bff3f34c6e3f9.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Tue, 04 Jan 2022 20:37:54 -0500
In-Reply-To: <YdT1gEF0zMIN6eQ8@hungrycats.org>
References: <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
         <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
         <YdSy09eCHqU5sgez@hungrycats.org>
         <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
         <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
         <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
         <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
         <YdTytv47JUGujVl5@hungrycats.org>
         <18d02df50fc7f9c63ff07b5433a445d911538be6.camel@ericlevy.name>
         <YdT1gEF0zMIN6eQ8@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2022-01-04 at 20:33 -0500, Zygo Blaxell wrote:

> That's up to the host filesystem implementation.  ZNS devices require
> filesystems that speak ZNS protocol.  They don't implement a
> traditional
> LBA-oriented interface (or if they do, they provide a separate
> logical
> device interface for that).

The entire file system must fit on one device, even the allocation
data. How would the host find the allocation information, if its
location has been remapped?


