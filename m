Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34AA485B8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbiAEWVa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 17:21:30 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45867 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244842AbiAEWV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 17:21:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 59CA25C0126;
        Wed,  5 Jan 2022 17:21:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jan 2022 17:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7cI9CcU62tEAnmWOH8mA0gwV17D
        OmIf5AT1mlwgR/AE=; b=zXFtCSSLnsq8TfX+SBAHlOCaJwOG5KfmV94FWB2qEa7
        81XWaQeEMyk5AYUl8uXmarh+Dmgb8M22IX1eS6gabd1sqNRHxufI9YbmCqz5TUR9
        5lIgBjBXqjUofqynGJ/qTlMK2xistJGNxxDsiyaY4jfToD/9gbd3vvVVjNFdUn6G
        bt8UKUM5pD5SrBXB0eGjLo85IaEFWPNgsJMWHVfJyIGugVhlrWv7FuisA5tfqNaG
        N+taoqbrp23u/wq+Ey53bjqbSrlGfUI2RaZSuJYNelaXhJLoXj7YcQsBq6EzwWDm
        nRINzKBaVklSzFoL813LLtPQwrvajr6CmW45O+gDwfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7cI9Cc
        U62tEAnmWOH8mA0gwV17DOmIf5AT1mlwgR/AE=; b=SMB/8q/jjvEojPdEj14bHW
        DSFlb3iJThjnxmsep9fOpJXCNDqJei45U6lUGGNkXa3QMtkLBE6A5P7Q26J046Ja
        a1sHdkRlx7ZQDF2+Q+ooi7W7LzzlOJI9ii2LR/TOt27JJPWB6WcpzOxHWKXad7bb
        I5CPrjZdsOqNS4Lz4TT1yQDZwJVsS931CpJuSBmpqJtvcVLOTcHi1bMSrfUDVizS
        dmIvofDbZcTcOnhd20vNUE3eT9cP2O+Cxd8NQqWq0MRwmYZMmJSMahUqNaTVOyqW
        Q70XS2giKQK92dgpljt81LiFNCPB7RdM2Dep7kXEakS9k2DPMmTY6uk3VoF2jH3g
        ==
X-ME-Sender: <xms:6BnWYVG93ndvz6ddeDXA9h4vAjnIzF8rkA-Tu1iVPeMPZ-wN8iXC-A>
    <xme:6BnWYaV9jzQMNDJ2RDtTk4sKj83fKxo8CY9ObeYwoZIPcV3vb_yua9L0CTruf_Jk4
    HZGaMLkK_pbsUEX6RM>
X-ME-Received: <xmr:6BnWYXIVdy0DlIy1uW467R8Ib46e2C512UfbFfshuJEC1lbPryF0VeZGzw6Dra5_34htRkdezGsaLNvHfmYfUAR4KfSF1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:6BnWYbH58z70I1zFyfcgBQbpe1YINMmK4EWGF_RstWcX-uz-bdpMpQ>
    <xmx:6BnWYbUapunBjLDAOv0YM0Q1s2V5z2HeEeb8tABNz447kRLA1u0QIA>
    <xmx:6BnWYWOZes3f3AmHRlhnKzk3-0fLSYw6d6SN4qcUvIsGcgUVGRQYvA>
    <xmx:6RnWYdIYKgFKcDcBJ68StXQZWM9k9pOXOYPNviUL7PC2ceqkVj7kZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 17:21:28 -0500 (EST)
Date:   Wed, 5 Jan 2022 14:21:27 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [RFC][V9][PATCH 0/6] btrfs: allocation_hint mode
Message-ID: <YdYZ5zkRGIUi31Cj@zen>
References: <cover.1639766364.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed this patchset still suffers from some checkpatch failures with
stuff like spaces around parens and minus signs, tabs vs spaces, etc. We
generally try to keep checkpatch happy in btrfs, though of course reason
should always prevail.

FWIW, I have it rebased on kdave/misc-next and ran:
checkpatch.pl -g kdave/misc-next..
