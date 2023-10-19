Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628B07CECC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 02:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjJSA2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Oct 2023 20:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjJSA15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Oct 2023 20:27:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA16120;
        Wed, 18 Oct 2023 17:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2589C433C9;
        Thu, 19 Oct 2023 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697675275;
        bh=2nh52jDJ6PylCe2C2NgD1C26nReaVji3095976lKB7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F8jNVxjwwNREaqtRMYhgWQLYcGrhhAcFqAvHSRLvDEMXpLEpQc5vcEyuuBIlaLBCc
         8eYPCv/oKbh9BlkdyIo0MoAgFO+EVrmwbn8hPcy5+rAmK6c+Th3k3zd6r48xwfnMOC
         npMX7cw86HSBBrcNGpXgmUSlyjScWsxfCRIcDMtF52OzyVtZZsdDRJm3NQOwMcWrfY
         H/5Uy8uNIG7mc8qcgS5ZZOwjFMoy4r5jNBWCoc4fIHcO/NDB7C3gJOuOQ66wFZpkU+
         2q2A4H6YDDL2cuC9g+fEzYj4Y/XKBwus5qeGAG/hbsj/6EszF8rXcnfkDo//f0fQ5j
         6MCqABy3D2JfA==
Date:   Wed, 18 Oct 2023 17:27:54 -0700
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
Subject: Re: [PATCH v2 04/13] linkmode: convert
 linkmode_{test,set,clear,mod}_bit() to macros
Message-ID: <20231018172754.3eec4885@kernel.org>
In-Reply-To: <20231016165247.14212-5-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
        <20231016165247.14212-5-aleksander.lobakin@intel.com>
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

On Mon, 16 Oct 2023 18:52:38 +0200 Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the non-atomic bitops are macros which can
> be expanded by the compilers into compile-time expressions, which will
> result in better optimized object code. Unfortunately, turned out that
> passing `volatile` to those macros discards any possibility of
> optimization, as the compilers then don't even try to look whether
> the passed bitmap is known at compilation time. In addition to that,
> the mentioned linkmode helpers are marked with `inline`, not
> `__always_inline`, meaning that it's not guaranteed some compiler won't
> uninline them for no reason, which will also effectively prevent them
> from being optimized (it's a well-known thing the compilers sometimes
> uninline `2 + 2`).
> Convert linkmode_*_bit() from inlines to macros. Their calling
> convention are 1:1 with the corresponding bitops, so that it's not even
> needed to enumerate and map the arguments, only the names. No changes in
> vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
> doesn't necessarily means the change is meaningless.

Acked-by: Jakub Kicinski <kuba@kernel.org>

This one can go in with the rest, it's trivial enough.
