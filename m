Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0AB323033
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 19:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBWSDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 13:03:37 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:57402 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231591AbhBWSDg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 13:03:36 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-35.iol.local with ESMTPA
        id Ec1hl4DFjpK9wEc1hlsbXQ; Tue, 23 Feb 2021 19:03:14 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614103394; bh=vdjR/KZtKZY/Fu7mxchO/JAJAkrWAo8UybyYxyJh3Wg=;
        h=From;
        b=PaFDOnGNlJZmUx82pJAuKeJMieQ86UVfnwAnDAsrMjjWSaOCmYMTsrdo0XOpLqOKH
         SAzBUzDoyLzWI7bfhW/3SylnCEcua1/pcfeGtI9JSIfTVpF9Cy9jdk79QlJ98aN82i
         fl6DCxVzpRPU+QBovLL1IFxo+0I+lTQHse+slMUDXpGcZzOC7xGQeZ0cWyinqiRKuQ
         hJpkoNyqlumpIiGYFvhhi2zJt3fjWU6vuKHQnMztUF2wb2agUfdsghLFI1kduMl5FB
         kegASJt9yY9z9268dqn1yzckFXbAiyWPDhg8ZcQZ1uRE6Ip5/ahoDm1hiSVP0f91vi
         +XrUjp7Y/UISw==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=60354362 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=N659UExz7-8A:10 a=anyJmfQTAAAA:8 a=XIb3VsYlAAAA:20 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=LLaAexG0WiAmXUx_w2IA:9 a=pILNOxqGKmIA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
To:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Goffredo Baroncelli <kreijack@inwind.it>
References: <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
 <202102231227.3AjnZHXh-lkp@intel.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <eeea2963-2fe9-0b86-3b5e-49b59bef7c78@libero.it>
Date:   Tue, 23 Feb 2021 19:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202102231227.3AjnZHXh-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOkwqoB+crbRomiMFzek/HuIukbAqOHslf8k50LJf1RvUue4VdcDQudLYDy9DqXiJHZnw6bL4EqhV8fPOEn0rbfvr8JBOuaQe9XCpB8Bz7wGwRdqlyb5
 UYIFtpcXiPFLGorjTDcW7mkuj5z1A9JOs09tEgxT0n4mwUuvv+ZlC2pnQxp7Ns4t5Iray+4Oos+DDYAuTw8skfUoxOX20IYkLJ6luQCTsu9vVVqIUX9nYWsp
 iFMnnFGlzFsWlsNi6cklPl0dIpEbLrbfl2GzLq/dn68=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/23/21 5:28 AM, kernel test robot wrote:
> Hi Goffredo,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on next-20210222]
> [cannot apply to v5.11]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Goffredo-Baroncelli/btrfs-add-ioctl-BTRFS_IOC_DEV_PROPERTIES/20210223-062001
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: i386-randconfig-r011-20210222 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/0day-ci/linux/commit/62c95ccebf2c45bb8e91d379b454dd720734da34
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Goffredo-Baroncelli/btrfs-add-ioctl-BTRFS_IOC_DEV_PROPERTIES/20210223-062001
>          git checkout 62c95ccebf2c45bb8e91d379b454dd720734da34
>          # save the attached .config to linux build tree
>          make W=1 ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     fs/btrfs/ioctl.c: In function 'btrfs_ioctl_dev_properties':
>>> fs/btrfs/ioctl.c:4923:1: warning: the frame size of 1036 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      4923 | }
>           | ^
> 
> 
> vim +4923 fs/btrfs/ioctl.c
> 
>    4858	
>    4859	static long btrfs_ioctl_dev_properties(struct file *file,
>    4860							void __user *argp)
>    4861	{
>    4862		struct inode *inode = file_inode(file);
>    4863		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>    4864		struct btrfs_ioctl_dev_properties dev_props;

Right, now that btrfs_ioctl_dev_properties is large 1k, it is not nice to store it in the stack...


>    4865		struct btrfs_device	*device;
>    4866		struct btrfs_root *root = fs_info->chunk_root;
>    4867		struct btrfs_trans_handle *trans;
>    4868		int ret;
>    4869		u64 prev_type;
>    4870	
>    4871		if (!capable(CAP_SYS_ADMIN))
>    4872			return -EPERM;
>    4873	
>    4874		if (copy_from_user(&dev_props, argp, sizeof(dev_props)))
>    4875			return -EFAULT;
>    4876	
>    4877		device = btrfs_find_device(fs_info->fs_devices, dev_props.devid,
>    4878					NULL, NULL);
>    4879		if (!device) {
>    4880			btrfs_info(fs_info, "change_dev_properties: unable to find device %llu",
>    4881				   dev_props.devid);
>    4882			return -ENODEV;
>    4883		}
>    4884	
>    4885		if (dev_props.properties & BTRFS_DEV_PROPERTY_READ) {
>    4886			u64 props = dev_props.properties;
>    4887	
>    4888			memset(&dev_props, 0, sizeof(dev_props));
>    4889			if (props & BTRFS_DEV_PROPERTY_TYPE) {
>    4890				dev_props.properties = BTRFS_DEV_PROPERTY_TYPE;
>    4891				dev_props.type = device->type;
>    4892			}
>    4893			if (copy_to_user(argp, &dev_props, sizeof(dev_props)))
>    4894				return -EFAULT;
>    4895			return 0;
>    4896		}
>    4897	
>    4898		/* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
>    4899		if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
>    4900			return -EPERM;
>    4901	
>    4902		trans = btrfs_start_transaction(root, 1);
>    4903		if (IS_ERR(trans))
>    4904			return PTR_ERR(trans);
>    4905	
>    4906		prev_type = device->type;
>    4907		device->type = dev_props.type;
>    4908		ret = btrfs_update_device(trans, device);
>    4909	
>    4910		if (ret < 0) {
>    4911			btrfs_abort_transaction(trans, ret);
>    4912			btrfs_end_transaction(trans);
>    4913			device->type = prev_type;
>    4914			return  ret;
>    4915		}
>    4916	
>    4917		ret = btrfs_commit_transaction(trans);
>    4918		if (ret < 0)
>    4919			device->type = prev_type;
>    4920	
>    4921		return ret;
>    4922	
>> 4923	}
>    4924	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
