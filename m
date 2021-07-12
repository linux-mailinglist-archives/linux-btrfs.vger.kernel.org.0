Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1240E3C4F6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbhGLHZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 03:25:46 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:47957 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344700AbhGLHUq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 03:20:46 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 8D41E8556
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 09:17:56 +0200 (MEST)
Date:   Mon, 12 Jul 2021 09:17:56 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: cannot use btrfs for nfs server
Message-ID: <20210712071756.GH1548@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>
 <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de>
 <475ccf1.ca37f515.17a8a262a72@tnonline.net>
 <20210709073444.GA582@tik.uni-stuttgart.de>
 <CAJCQCtR=Xar+0pD9ivhk-kfrWxTxbJpVYu3z8A617GKshf2AsA@mail.gmail.com>
 <20210710063535.GE1548@tik.uni-stuttgart.de>
 <2fd105cb-c097-63e8-0c43-049dceeb93c9@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd105cb-c097-63e8-0c43-049dceeb93c9@tnonline.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun 2021-07-11 (13:41), Forza wrote:

> btrfs subvolume list -to /data/fex

root@tsmsrvj:/# btrfs subvolume list -to /data/fex
ID      gen     top level       path
--      ---     ---------       ----
270     1471    257             fex/spool


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<2fd105cb-c097-63e8-0c43-049dceeb93c9@tnonline.net>
