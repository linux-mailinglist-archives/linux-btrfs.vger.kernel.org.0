Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC8428AB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhJKKZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:25:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60942 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhJKKZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:25:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A502322079;
        Mon, 11 Oct 2021 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633947808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klqUqQg5ksk+Ycg4+uKGF0HhAuQdKVqUcBMSAhJM24k=;
        b=W0G3sES1EbS/OqWVg1GcG3Z8okcf5x5cVxaVl8R7XHAOiBtuo55lTRrkC1IvuGI+cPWnXw
        KTBF5kukOIfYBAKU+HGluguaxsAE9v3fVZx21HPzhC9a4jSyTco2RdYH+4FsFi5J0hYmae
        /iLu4Z3rLSCYW2ElqQbbWpicpyK7T2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633947808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klqUqQg5ksk+Ycg4+uKGF0HhAuQdKVqUcBMSAhJM24k=;
        b=c9eZMZDqryBfunRdJ2jsBkh4jFBd34zMIXsi7GHwfeiM2rgyZm0yhVI+lNQgm2VqyA5ECo
        +Lfw0v/OBa1kpbAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4CA3CA3B85;
        Mon, 11 Oct 2021 10:23:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53878DA704; Mon, 11 Oct 2021 12:23:05 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:23:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Sven Oehme <oehmes@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: Host managed SMR drive issue
Message-ID: <20211011102305.GC9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Sven Oehme <oehmes@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <CALssuR3SQPev0f2GYo0s-w3pk-jP-GGPZiX2vx9597NQBW8gUQ@mail.gmail.com>
 <PH0PR04MB74162F06A2AD5D8379F2682C9BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1wcChWwLt1wVoxhf=ufWdKtBHa7FXn-m9mkJcpPGbfOg@mail.gmail.com>
 <PH0PR04MB7416408BFBD494211A4D86B69BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1JZqaBLf_aCMRLm683cww66wc_p+hgCpCENMiQkVoSRg@mail.gmail.com>
 <20211006154828.bqiwik2b6jaqxcck@naota-xeon>
 <CALssuR3UeNmx0PnwUT8ZR0bOd9iAGjvgmv9u8yfHDnfpChKb2w@mail.gmail.com>
 <20211007032239.iwrtygcavadvvb62@naota-xeon>
 <CH0PR14MB50764AC8659E9378C65D6DE8F4B19@CH0PR14MB5076.namprd14.prod.outlook.com>
 <MW4PR04MB7411E69C4D7FDC0121FA159F9BB59@MW4PR04MB7411.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR04MB7411E69C4D7FDC0121FA159F9BB59@MW4PR04MB7411.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 06:32:35AM +0000, Johannes Thumshirn wrote:
> [ +Cc linux-btrfs ]
> 
> On 07/10/2021 14:18, Sven Oehme wrote:
> > Thu Oct  7 06:09:30 2021] ------------[ cut here ]------------
> > 
> > [Thu Oct  7 06:09:30 2021] BTRFS: Transaction aborted (error -22)
> > 
> > [Thu Oct  7 06:09:30 2021] WARNING: CPU: 8 PID: 73260 at fs/btrfs/ctree.c:491 
> > __btrfs_cow_block+0x3d8/0x5a0 [btrfs]
> > 
> > [Thu Oct  7 06:09:30 2021] Modules linked in: vhost_vsock 
> > vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock xt_conntrack 
> > nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack 
> > nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user nft_counter rpcsec_gss_krb5 nfsv4 nfs 
> > fscache netfs xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp 
> > llc cuse overlay nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc 
> > scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd 
> > kvm rapl efi_pstore ipmi_ssif joydev input_leds ftdi_sio usbserial ccp k10temp 
> > acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel nfsd 
> > auth_rpcgss nfs_acl lockd grace msr sunrpc ip_tables x_tables autofs4 btrfs 
> > blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy 
> > async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear 
> > ses enclosure hid_lenovo hid_generic usbhid hid ast drm_vram_helper 
> > drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper
> > 
> > [Thu Oct  7 06:09:30 2021]  crc32_pclmul syscopyarea ghash_clmulni_intel 
> > sysfillrect sysimgblt aesni_intel fb_sys_fops crypto_simd cec cryptd rc_core 
> > nvme mpt3sas ahci drm ixgbe raid_class libahci igb smartpqi nvme_core xhci_pci 
> > xfrm_algo scsi_transport_sas xhci_pci_renesas i2c_piix4 dca i2c_algo_bit mdio
> > 
> > [Thu Oct  7 06:09:30 2021] CPU: 8 PID: 73260 Comm: kworker/u98:0 Not tainted 
> > 5.13.0-rc6-fix2 #3
> 
> Hi sorry for the late reply, I've been to a conference.
> 
> This is already fixed in current btrfs misc-next, but not sure if the fix is 
> already in Linus' tree.

Which fix is that please?
