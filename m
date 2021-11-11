Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928CD44D214
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 07:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhKKG4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 01:56:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:44977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhKKG4x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 01:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636613642;
        bh=pahYUPz5ZkyGRmbCfQ3zcNNFdpYiIz5qfX+A45yijGg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bPisSELMbDK0sqobBjYXtLEO2aRI1O3iq66cpPf1nm7GT0Jwk9m9EI2dl+q8t4dFY
         bJFX0ZnGphIuCtURIQRhk53TXDKBz+pGT6Xp3Y5FGfDo/5UIzoTk/iUBPP4WHwqncj
         tcn7H9VtsDQ00zknY73DM1gXpVrsK19pgMHoOBbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryT9-1mO32K1TDZ-00o1MC; Thu, 11
 Nov 2021 07:54:02 +0100
Message-ID: <68ad2de1-6b5e-7709-36f5-84c61d0e5079@gmx.com>
Date:   Thu, 11 Nov 2021 14:53:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     "S ." <sb56637@gmail.com>
References: <20211111024138.41687-1-wqu@suse.com>
 <3644e6ea-1756-5fd0-106b-2d130f6a2c2b@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: rescue: introduce clear-uuid-tree
In-Reply-To: <3644e6ea-1756-5fd0-106b-2d130f6a2c2b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrpPbOZdUssD6yftDiYL3+RZnG+fwjwR8SzgaAP0wsInXFbEUnl
 B/MTZYyJoLmmGW9bz1jjbj4ASCVbAzEPYrVk0AvzA3Z01OCPcwQPO2WogPXLhyfGJxPcBBf
 En2L77BGGv2UkmUvwdopdSw7IcIXr2erT5glHS3MF/7xkEEalgBapCr/ZomjJmk8cYzf/Ng
 mjgIO4Je4mShsedD3ebkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UgWNNstLWr4=:duWeRqXukr69t+RuQZ/blE
 4bz0w0FwY6I//lG4SjHZVUmGMUIng8Bup5oNd6uSquMv9oA36xz2zJ3+eO8m0hfuD4ZBKZY5D
 4JwNlWTFPsT4L3lQVclk24kyKZ60KQgUl5tTCLqPSAqtVv1NKsfHeH/CqGoxVSysondfjOyki
 O/Prnc5G4Tkyy2irdk5CIcx8tbWp+7OkAFbQSV/LU4j4Myx+hL23ysDVodMmQsGvt7EX8UWct
 voMHm+m69tGvPzhA3QNo44kLwvOgDX/I5cRWXBTPyBm5Uj5gSyx1Cz2uGbW4mtZZ2+XpIfp88
 cPVmsQaMpTHHtgfALavBnrt0sAPiiCcW9zj+RVTDHigQUjIKjaFrk7QzOj6jKRmmUYHkvd9EN
 WaT8bso+kloA1kxhito99yfrggULT7Es6d3HSdGEN3RGaEVauPaKbQcPnNEbuEDJJhiZQRG12
 q1hQPHS94U+jd6Rellol4S4JqRwno9AcntGk32yB9JSDSe4kiUiw6+xtPhuOeNKLoi/oyqQH8
 lLFN6mS0Jcpa/F9XuVrRrqGhvmlfqbY+wBtLPDecIo3HNORTM+n2WguiQi7+FZ65sgsWWdAw8
 wQ3jbzqijGDi90XM2zAVXxo5gF3+WJDO9IZEIxg5v7MgMnNoRSfKe1rXrKqBZvLkMf3WZzKE8
 n/8peeHidrz/Gbxap/698n7FNF+NAS4XYIJ0yGV4UhIgwg3FrpW5LvTGLgvNIqQxE5qM7+y0L
 rjOY6r1enXhswBVQeIdXrm97QkDBQA8UptsYuAyLiDJG/fo5bhIufsCpJdW1Ux3iiEvYgy2sG
 b8aIFlaWPYzfQs5S+YT5S2OBMaHARRHl6jBQX8eHGwbcZzj4l1nqHHe09r0fbnnNBa4rGPmog
 0Jmr0JjiLp/DWyyvdA+p4V0Vxb13dQrzxcYVdUo4FKVqDeYJ/BDds3r5TpkEwqgPHO+3vA8R5
 5kC65DR3EtQSdUD11LU2zjpmpGQuioWeM4DQQUeIalV+2zpGgqCOB9Q0ECaAetJZS9UFx+fKQ
 d6CPwErM8WlPysOSolzIaWl2W2rfjZHaTscGZCB1cCDsglOnFtByCP5EZZc9yXa2T9ovbUFoR
 ze4WtEZpdLstX0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/11 14:37, Nikolay Borisov wrote:
>
>
> On 11.11.21 =D0=B3. 4:41, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that a corrupted key type (expected
>> UUID_KEY_SUBVOL, has EXTENT_ITEM) causing newer kernel to reject a
>> mount.
>>
>> Although the root cause is not determined yet, with roll out of v5.11
>> kernel to various distros, such problem should be prevented by
>> tree-checker, no matter if it's hardware problem or not.
>>
>> And older kernel with "-o uuid_rescan" mount option won't help, as
>> uuid_rescan will only delete items with
>> UUID_KEY_SUBVOL/UUID_KEY_RECEIVED_SUBVOL key types, not deleting such
>> corrupted key.
>>
>> [FIX]
>> To fix such problem we have to rely on offline tool, thus there we
>> introduce a new rescue tool, clear-uuid-tree, to empty and then remove
>> uuid tree.
>>
>> Kernel will re-generate the correct uuid tree at next mount.
>
> SHouldn't this be made part of btrfs repair, why do we need specific
> rescue subcom ?

Because btrfs check doesn't yet check uuid tree at all, and the problem
we hit here should be pretty rare, thus I prefer to just remove the uuid
tree and let newer kernel to regenerate it.

Thanks,
Qu
>
>>
>> Reported-by: S. <sb56637@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   cmds/rescue.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
>>   1 file changed, 104 insertions(+)
>>
>> diff --git a/cmds/rescue.c b/cmds/rescue.c
>> index a98b255ad328..8b5b619da4f6 100644
>> --- a/cmds/rescue.c
>> +++ b/cmds/rescue.c
>> @@ -296,6 +296,109 @@ static int cmd_rescue_create_control_device(const=
 struct cmd_struct *cmd,
>>   }
>>   static DEFINE_SIMPLE_COMMAND(rescue_create_control_device, "create-co=
ntrol-device");
>>
>> +static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
>> +{
>> +	struct btrfs_root *uuid_root =3D fs_info->uuid_root;
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_path path =3D {};
>> +	struct btrfs_key key =3D {};
>> +	int ret;
>> +
>> +	if (!uuid_root)
>> +		return 0;
>> +
>> +	fs_info->uuid_root =3D NULL;
>> +	trans =3D btrfs_start_transaction(fs_info->tree_root, 0);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	while (1) {
>> +		int nr;
>> +
>> +		ret =3D btrfs_search_slot(trans, uuid_root, &key, &path, -1, 1);
>> +		if (ret < 0)
>> +			goto out;
>> +		ASSERT(ret > 0);
>> +		ASSERT(path.slots[0] =3D=3D 0);
>> +
>> +		nr =3D btrfs_header_nritems(path.nodes[0]);
>> +		if (nr =3D=3D 0) {
>> +			btrfs_release_path(&path);
>> +			break;
>> +		}
>> +
>> +		ret =3D btrfs_del_items(trans, uuid_root, &path, 0, nr);
>> +		btrfs_release_path(&path);
>> +		if (ret < 0)
>> +			goto out;
>> +	}
>> +	ret =3D btrfs_del_root(trans, fs_info->tree_root, &uuid_root->root_ke=
y);
>> +	if (ret < 0)
>> +		goto out;
>> +	list_del(&uuid_root->dirty_list);
>> +	ret =3D clean_tree_block(uuid_root->node);
>> +	if (ret < 0)
>> +		goto out;
>> +	ret =3D btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1=
);
>> +	if (ret < 0)
>> +		goto out;
>> +	free_extent_buffer(uuid_root->node);
>> +	free_extent_buffer(uuid_root->commit_root);
>> +	kfree(uuid_root);
>> +out:
>> +	if (ret < 0)
>> +		btrfs_abort_transaction(trans, ret);
>> +	else
>> +		ret =3D btrfs_commit_transaction(trans, fs_info->tree_root);
>> +	return ret;
>> +}
>> +
>> +static const char * const cmd_rescue_clear_uuid_tree_usage[] =3D {
>> +	"btrfs rescue clear-uuid-tree",
>> +	"Delete uuid tree so that kernel can rebuild it at mount time",
>> +	NULL,
>> +};
>> +
>> +static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
>> +				      int argc, char **argv)
>> +{
>> +	struct btrfs_fs_info *fs_info;
>> +	struct open_ctree_flags ocf =3D {};
>> +	char *devname;
>> +	int ret;
>> +
>> +	clean_args_no_options(cmd, argc, argv);
>> +	if (check_argc_exact(argc, 2))
>> +		return -EINVAL;
>> +
>> +	devname =3D argv[optind];
>> +	ret =3D check_mounted(devname);
>> +	if (ret < 0) {
>> +		errno =3D -ret;
>> +		error("could not check mount status: %m");
>> +		goto out;
>> +	} else if (ret) {
>> +		error("%s is currently mounted", devname);
>> +		ret =3D -EBUSY;
>> +		goto out;
>> +	}
>> +	ocf.filename =3D devname;
>> +	ocf.flags =3D OPEN_CTREE_WRITES | OPEN_CTREE_PARTIAL;
>> +	fs_info =3D open_ctree_fs_info(&ocf);
>> +	if (!fs_info) {
>> +		error("could not open btrfs");
>> +		ret =3D -EIO;
>> +		goto out;
>> +	}
>> +
>> +	ret =3D clear_uuid_tree(fs_info);
>> +	close_ctree(fs_info->tree_root);
>> +out:
>> +	return !!ret;
>> +}
>> +
>> +static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree"=
);
>> +
>>   static const char rescue_cmd_group_info[] =3D
>>   "toolbox for specific rescue operations";
>>
>> @@ -306,6 +409,7 @@ static const struct cmd_group rescue_cmd_group =3D =
{
>>   		&cmd_struct_rescue_zero_log,
>>   		&cmd_struct_rescue_fix_device_size,
>>   		&cmd_struct_rescue_create_control_device,
>> +		&cmd_struct_rescue_clear_uuid_tree,
>>   		NULL
>>   	}
>>   };
>>
