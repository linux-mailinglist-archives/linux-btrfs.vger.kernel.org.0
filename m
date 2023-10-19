Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA77CECC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjJSA1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 20:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSA1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 20:27:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC9FE;
        Wed, 18 Oct 2023 17:27:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB4C433C7;
        Thu, 19 Oct 2023 00:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697675268;
        bh=jHDQqSS8ZaH9Uy7TQHB6qJm6Cs7OcqGT8rO524V8Zow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eKdfe0Ofzge00ZDfDlnuCMUEScoQywz09l4jkmlclhCPRw0u00shfEbaLaa8zMx9E
         lQ7iLz39Y53gPcWphz9okx9ykrt/I3WPsmXrRaNlfA+Ex5sFWXvUo3jIJNJKXtQO7r
         bMe1uwejICnTXHwHyhN8fS19yvRR/Aac0wubmU4FeNI4nYTZGOz0P2OaWXUn2gsNyu
         Rn7qpjcfpBwBXDOSzmO7g0UB4cm9obwYPAUcmeEP0Jb4pSRxhsgRyTRaLZpWwVTPdX
         VMcQ9/07YBtVuFo26rtQdLIC0AHRV8cmvwKiJMmIH35Xu81SqGaTzjHdoMiLTZHyfG
         8KgCl4U7k2gNw==
Date:   Wed, 18 Oct 2023 17:27:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Message-ID: <20231018172747.305c65bd@kernel.org>
In-Reply-To: <20231016165247.14212-12-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
        <20231016165247.14212-12-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
>  40 files changed, 715 insertions(+), 415 deletions(-)

This already has at least two conflicts with networking if I'm looking
right. Please let the pre-req's go in via Yury's tree and then send
this for net-next in the next release cycle.
