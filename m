Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F262A126
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKOSNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOSNh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:13:37 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5928E22
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:13:35 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id CDA6A4056D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:17:27 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id A3B5480366A0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:13:34 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 94B0F80366A1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:13:34 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZbSpYKqGvzaQ for <linux-btrfs@vger.kernel.org>;
        Tue, 15 Nov 2022 12:13:34 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 45F9280366A0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:13:34 -0600 (CST)
Date:   Tue, 15 Nov 2022 13:13:27 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: property designating root subvolumes
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <FMIELR.O8OGGM9UHOZV2@ericlevy.name>
In-Reply-To: <6e932071-ef89-0d69-550f-755abea004ba@gmail.com>
References: <VB2DLR.FVM1D1665BSY2@ericlevy.name>
        <6e932071-ef89-0d69-550f-755abea004ba@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Nov 15 2022 at 08:50:50 PM +0300, Andrei Borzenkov 
<arvidjaar@gmail.com> wrote:
> On 15.11.2022 02:23, Eric Levy wrote:
>> The file system allows one subvolume per partition to be designated 
>> as
>> the default, and no more than one would be sensible. Generally, for
> 
> It is not partition, it is filesystem.

I'm sorry, but I fail to understand any distinction from your comment 
that clarifies a genuine confusion, within the present context, more 
than a semantic nuance.


>> So far the only usage proposed by you is to scan btrfs subvolumes to 
>> apparently present user multiple choices during boot. Any bootloader 
>> that understands btrfs enough to read subvolume properties can also 
>> read information inside subvolume to achieve the same effect. You 
>> need to prepare subvolume anyway.

A bootloader may not be the best location to include logic for 
descending into a subvolume, to resolve whether it contains a root file 
hierarchy. Meanwhile, some subvolumes, such a snapshots, may appear 
internally as root subvolumes, though not being desired for entries on 
a boot menu. Presently, it is worth considering the historic precedent 
that the default subvolume is being used to identify a location for a 
root file hierarchy. The association often holds, but is not the basis 
of any fully robust assumption.


> If you suggest some other usage I am afraid I failed to understand it.

I will let others express whether they understand more clearly.


