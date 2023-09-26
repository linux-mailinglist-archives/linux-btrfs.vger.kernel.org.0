Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C66B7AE981
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjIZJpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjIZJpW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 05:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33CBE
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 02:45:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B27C433C8;
        Tue, 26 Sep 2023 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695721515;
        bh=tWg7n/mmA2r5XjhtYAZMgX8S29ybOU0FsdEXJU4kAjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+vn7ozEWySbyldqBSxUxg6vIZd3bDbpB270zzoSmX9to7FOArt11LJUgvxI6txYV
         5s/odD0ktevE8llSphLqiA6XKzMLSm6tyeISbm+5ecFcO9KJZiz4UFj7Qk7aYD8KBB
         EkUrmEdqN/TMur6T+EQ1uOmym7D/ih0wQ23+8eelnGsGsv8uJ1LDYUxHLUEYidMXWE
         X1gW8UHrIUIDELTFTlGwvs/t4CQBwJW04nsdGANFKYYJm+bUPgKANR/pLofQfvta9L
         RUyTa4cNjx2qCNLqHFGCceLR1VsrCjUkKyBIgTyVzGwJJCoBfHZo5mVCOOzc87uoiq
         NVkDz6dhEtRsg==
Date:   Tue, 26 Sep 2023 11:45:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RESEND] btrfs: use the super_block as holder when
 mounting file systems
Message-ID: <20230926-abgeladen-suchhunde-fe095f7f707b@brauner>
References: <20230921121945.4701-1-jack@suse.cz>
 <20230925155409.GO13697@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925155409.GO13697@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 05:54:09PM +0200, David Sterba wrote:
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>

> it'll be in linux-next. The series has been sitting in the review
> backlog for a few weeks but no takers. I try to have a look from time

I don't understand isn't Josef one of your reviewers/maintainers? Who is
the person that must review it?
