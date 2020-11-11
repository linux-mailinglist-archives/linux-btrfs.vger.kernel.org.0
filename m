Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B2E2AE5DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 02:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKKBdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 20:33:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60301 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730894AbgKKBdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 20:33:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BB605C0371;
        Tue, 10 Nov 2020 20:33:48 -0500 (EST)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Tue, 10 Nov 2020 20:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=kCWi+5dHnld69Z1n4gOCY8eUU5tn4vY
        JAbXHT2qinWI=; b=Xg6oL/6TP7enYL5ZCsR6e7WdhFogIszPRKewpVUEfy6WTd8
        zdrFiOzH5DW/hcE3ECAQbj1CX9YcIWMnUK0MHW+lbeBycyFdrMqdvoIHFuIDB2+B
        jUWhKObSyCCPlezYihnYU0JehpRPTqaL6kdL/rxaH8XQPv7LoqHu8n58s51AY/w9
        5zrPHYXgao7+iIWseaaz7O/zBS+1mJ24G6TLO67LSlCtGhX3bAn/EtZ38/OouZJY
        zpAMA2weTOQtXH2cmcQhApD2AG12xqarJ+0qMZT02FeMGmSFBeLkYN8QZBoqBAmn
        ETQw1SF5wxCfLn/Dv8BkJ1V25mFPungozZM0/Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kCWi+5
        dHnld69Z1n4gOCY8eUU5tn4vYJAbXHT2qinWI=; b=EcgzMxWRVKmKQv/VanYKtS
        9127I5v2s8omlEvs2eGSEbHsied9XlbrOuJXO1oe0oGV3aQtKwBhnc3kBX/HH81L
        OdkyMJX6vM0YOIMR0qW/dLb9gTq+vF2JNsDSAUERHxWU70p5GJmIoL0VrE+cPTvE
        6bH8DX05i8ESDktBioe5nwyw7MFN1E9yCEjPZ5m+J/3ajMKwnoxkhxCy0v9JvOZ7
        n7IXeYY8gUrUqlibgKaoCGSNp4p9y1Ru4JdnRn4kzOOaIkDIlCqsDAw6J2jA4H4O
        yC5MxuC2le/VD/4K89zjXgSroUy1TkH1XPe2WrANJxAdkjxKoVKgGPPC8hf1WLLg
        ==
X-ME-Sender: <xms:fD-rX73LK_E2sT1bamNnuuhvtDXlDhdDzIlHCyJNJa4pKDYvh60buQ>
    <xme:fD-rX6Gp4whFJ5UUKzuV8UsfYpRmuEf05arQJOmzzKz7Xe8OQH-6_OfX3Hdc2QwL8
    G_uuwno94W7HSTD8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepffetvefgvdeifeegueeuffevfefhudehgefgkeetfefg
    ieeuueeihffhvdevjeetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:fD-rX743IkngLfggAFpmI_HAAPuua6qNcF-yLCSfRgeD9JMvIOUD8g>
    <xmx:fD-rXw3csU3MYw1WlGI0pFDUHO8Qn5XFfhT77mZkSiC93ViWMcUTuA>
    <xmx:fD-rX-Ejrj58CQbSWezZ8kIYOYYI8OCKRis8wND9t_qa4CQS34Z5lg>
    <xmx:fD-rX5NOy-a7rDmqn98qLg70co2vu3YFAw7iEyaD2fopXfruv5bcVw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EE4FD14C00BD; Tue, 10 Nov 2020 20:33:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-570-gba0a262-fm-20201106.001-gba0a2623
Mime-Version: 1.0
Message-Id: <ceedc232-fc78-4c2e-822a-0938331c6f6d@www.fastmail.com>
In-Reply-To: <052b7f70aee959f0c724b3d0524a727b5e1f102d.1604013169.git.dxu@dxuuu.xyz>
References: <cover.1604013169.git.dxu@dxuuu.xyz>
 <052b7f70aee959f0c724b3d0524a727b5e1f102d.1604013169.git.dxu@dxuuu.xyz>
Date:   Tue, 10 Nov 2020 17:33:27 -0800
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     "Kernel Team" <kernel-team@fb.com>
Subject: =?UTF-8?Q?Re:_[PATCH_1/3]_btrfs-progs:_rescue:_Add_create-control-device?=
 =?UTF-8?Q?_subcommand?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020, at 4:17 PM, Daniel Xu wrote:
> This commit adds a new `btrfs rescue create-control-device` subcommand
> that creats /dev/btrfs-control. This is helpful on systems that may not
> have `mknod` installed.
> 
> Link: https://github.com/kdave/btrfs-progs/issues/223
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  cmds/rescue.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
[...]

Ping
